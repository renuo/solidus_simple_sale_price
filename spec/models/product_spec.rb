require 'spec_helper'

describe Spree::Product do
  it 'can query its sale prices' do
    product = build(:product, price: 1337.42)
    expect(product.original_price).to eq 1337.42
    expect(product.on_sale?).to be false

    product.master.default_price.update!(amount: 1337.42, sale_amount: 20.18)

    expect(product.price).to eq 20.18
    expect(product.original_price).to eq 1337.42
    expect(product.on_sale?).to be true

    product.master.default_price.update!(amount: 19.89)

    expect(product.price).to eq 19.89
    expect(product.original_price).to eq 19.89
    expect(product.on_sale?).to be false
  end

  context 'when the price is not set yet' do
    it 'returns nil for the sale and original price' do
      product = described_class.new
      expect(product.master.sale_price_in('EUR')).to eq nil
      expect(product.master.original_price_in('EUR')).to eq nil
    end
  end
end
