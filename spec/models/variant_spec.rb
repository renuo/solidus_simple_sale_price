require 'spec_helper'

describe Spree::Variant do
  let(:normal_price) { build(:price, amount: 19.89) }
  let(:price_on_sale) { build(:price, amount: 1337.42, sale_amount: 20.18) }

  it 'can query the sale price' do
    variant = create(:variant)
    expect(variant.on_sale?).to be false

    variant.default_price = price_on_sale

    expect(variant.on_sale?).to be true
    expect(variant.original_price).to eql 1337.42
    expect(variant.sale_price).to eql 20.18
    expect(variant.price).to eql 20.18
  end

  it 'can query the sale price for each currency' do
    variant = create(:international_variant)

    variant.prices.each do |p|
      p.amount = 19.99
      p.sale_amount = 10.95
      p.save!

      expect(variant.on_sale_in?(p.currency)).to be true
      expect(variant.price_in_currency(p.currency).price).to eq BigDecimal(10.95, 4)
      expect(variant.sale_price_in(p.currency).price).to eql BigDecimal(10.95, 4)
      expect(variant.original_price_in(p.currency).price).to eql BigDecimal(19.99, 4)
    end
  end

  it 'can query sale prices for some specific currencies' do
    variant = create(:international_variant, price_currencies: %w[CHF GBP AUD KES])

    some_prices = variant.prices.where(currency: %w[AUD CHF])
    other_prices = variant.prices.where(currency: %w[GBP KES])

    some_prices.each do |p|
      p.sale_amount = 10.95
      p.save!

      expect(variant.price_in_currency(p.currency).price).to be_within(0.01).of(10.95)
      expect(variant.sale_price_in(p.currency).price).to eql BigDecimal(10.95, 4)
      expect(variant.original_price_in(p.currency).price).to eql BigDecimal(19.99, 4)
    end

    other_prices.each do |p|
      expect(variant.price_in_currency(p.currency).price).to eql(BigDecimal(19.99, 4))
      expect(variant.sale_price_in(p.currency).price).to be_nil
      expect(variant.original_price_in(p.currency).price).to eql BigDecimal(19.99, 4)
    end
  end

  it 'can set the original price to something different without changing the sale price' do
    variant = create(:international_variant)
    variant.prices.each do |p|
      p.sale_amount = 10.95
      p.original_amount = 12.90
    end

    variant.prices.each do |p|
      expect(p.on_sale?).to be true
      expect(p.price).to eq BigDecimal(10.95, 4)
      expect(p.sale_amount).to eq BigDecimal(10.95, 4)
      expect(p.original_amount).to eq BigDecimal(12.90, 4)
    end
  end

  it 'calculates discount difference' do
    variant = create(:international_variant, price_currencies: %w[CHF GBP])
    variant.prices.each do |p|
      p.sale_amount = 10.00
      p.original_amount = 20.00
      p.save!
    end

    expect(variant.discount_percent_in('CHF')).to eql(50)
    expect(variant.discount_percent_in('GBP')).to eql(50)
  end

  describe '.price_in_currency' do
    let(:variant) { create(:variant) }

    before do
      variant.prices << create(:price, variant: variant, currency: 'EUR', amount: 33.33)
    end

    subject do
      variant.price_in_currency(currency)
    end

    context 'when currency is not specified' do
      let(:currency) { nil }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when currency is EUR' do
      let(:currency) { 'EUR' }

      it 'returns the value in the EUR' do
        expect(subject.display_price.to_s).to eql '€33.33'
      end
    end

    context 'when currency is USD' do
      let(:currency) { 'USD' }

      it 'returns the value in the USD' do
        expect(subject.display_price.to_s).to eql '$19.99'
      end
    end
  end
end
