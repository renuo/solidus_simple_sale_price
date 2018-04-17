require 'spec_helper'

describe Spree::SalePrice do
  it 'can start' do
    sale_price = build(:sale_price)
    sale_price.start

    expect(sale_price).to be_enabled
  end

  it 'can stop' do
    sale_price = build(:active_sale_price)
    sale_price.stop

    expect(sale_price).not_to be_enabled
  end

  it 'can create a money price ready to display' do
    sale_price = build(:active_sale_price)
    money = sale_price.display_price

    expect(money).to be_a Spree::Money
    expect(money.money.currency).to eq(sale_price.currency)
    expect(money.money.amount).to eq(sale_price.calculated_price)
  end
end
