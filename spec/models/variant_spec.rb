require 'spec_helper'

describe Spree::Variant do
  it 'can put a variant on a standard sale' do
    variant = create(:variant)
    expect(variant.on_sale?).to be false

    variant.put_on_sale 10.95

    expect(variant.on_sale?).to be true
    expect(variant.original_price).to eql 19.99
    expect(variant.price).to eql 10.95
  end

  it 'changes the price of all attached prices' do
    variant = create(:international_variant)
    variant.put_on_sale 10.95

    expect(variant.prices.count).not_to eql 0
    variant.prices.each do |p|
      expect(p.price).to eql BigDecimal.new(10.95, 4)
    end
  end

  it 'changes the price for each currency' do
    variant = create(:international_variant)

    variant.prices.each do |p|
      variant.put_on_sale 10.95, { currencies: [ p.currency ] }

      expect(variant.price_in(p.currency).price).to eq BigDecimal.new(10.95, 4)
      expect(variant.original_price_in(p.currency).price).to eql BigDecimal.new(19.99, 4)
    end
  end

  it 'changes the price some specific currencies' do
    variant = create(:international_variant, price_currencies: ['CHF', 'GBP', 'AUD', 'KES'])

    some_prices = variant.prices.where(currency: ['AUD', 'CHF'])
    other_prices = variant.prices.where(currency: ['GBP', 'KES'])

    variant.put_on_sale(10.95, { currencies: some_prices.map(&:currency)})

    some_prices.each do |p|
      expect(variant.price_in(p.currency).price).to be_within(0.01).of(10.95)
      expect(variant.original_price_in(p.currency).price).to eql BigDecimal.new(19.99, 4)
    end

    other_prices.each do |p|
      expect(variant.price_in(p.currency).price).to eql(BigDecimal.new(19.99, 4))
      expect(variant.original_price_in(p.currency).price).to eql BigDecimal.new(19.99, 4)
    end
  end

  it 'can set the original price to something different without changing the sale price' do
    variant = create(:international_variant)
    variant.put_on_sale(10.95)
    variant.prices.each do |p|
      p.original_price = 12.90
    end

    variant.prices.each do |p|
      expect(p.on_sale?).to be true
      expect(p.price).to eq BigDecimal.new(10.95, 4)
      expect(p.sale_price).to eq BigDecimal.new(10.95, 4)
      expect(p.original_price).to eq BigDecimal.new(12.90, 4)
    end
  end

  it 'is not on sale anymore if the original price is lower than the sale price' do
    variant = create(:international_variant)
    variant.put_on_sale(10.95)
    variant.prices.each do |p|
      p.original_price = 9.90
    end

    variant.prices.each do |p|
      expect(p.on_sale?).to be false
      expect(p.price).to eq BigDecimal.new(9.90, 4)
      expect(p.sale_price).to eq nil
      expect(p.original_price).to eq BigDecimal.new(9.90, 4)
    end
  end

  context 'with a valid sale' do
    it 'can disable and enable a sale for all currencies' do
      variant = create(:international_variant)
      variant.put_on_sale(10.95)

      variant.disable_sale
      variant.prices.each do |p|
        expect(variant.on_sale_in?(p.currency)).to be false
      end

      variant.enable_sale
      variant.prices.each do |p|
        expect(variant.on_sale_in?(p.currency)).to be true
      end
    end

    it 'can disable and enable a sale for some currencies' do
      variant = create(:international_variant, price_currencies: ['CHF', 'GBP', 'AUD', 'KES'])
      variant.put_on_sale(10.95)

      some_prices = variant.prices.where(currency: ['KES', 'CHF'])
      other_prices = variant.prices.where(currency: ['GBP', 'AUD'])

      variant.disable_sale(['KES', 'CHF'])

      some_prices.each do |p|
        expect(variant.on_sale_in?(p.currency)).to be false
      end
      other_prices.each do |p|
        expect(variant.on_sale_in?(p.currency)).to be true
      end

      variant.enable_sale(['KES', 'CHF'])

      variant.prices.each do |p|
        expect(variant.on_sale_in?(p.currency)).to be true
      end
    end
  end
end
