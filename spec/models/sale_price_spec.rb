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
    display_price = sale_price.display_price

    expect(display_price).to be_a Spree::Money
    expect(display_price.money.currency).to eq(sale_price.currency)

    # TODO: there are rounding errors!
    # expect(display_price.money.amount).to eq(sale_price.calculated_price)
  end
end
