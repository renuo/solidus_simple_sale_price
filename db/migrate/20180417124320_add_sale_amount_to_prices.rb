class AddSaleAmountToPrices < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_prices, :sale_amount, :decimal, precision: 10, scale: 2
  end
end
