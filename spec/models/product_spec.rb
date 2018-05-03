require 'spec_helper'

describe Spree::Product do
  it 'can query its sale prices' do
    product = build(:product, price: 1337.42)
    expect(product.original_price).to eql 1337.42
    expect(product.on_sale?).to be false

    price_on_sale = build(:price, amount: 1337.42, sale_amount: 20.18)
    product.master.default_price = price_on_sale

    expect(product.price).to eql 20.18
    expect(product.original_price).to eql 1337.42
    expect(product.on_sale?).to be true

    normal_price = build(:price, amount: 19.89)
    product.master.default_price = normal_price

    expect(product.price).to eql 19.89
    expect(product.original_price).to eql 19.89
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
