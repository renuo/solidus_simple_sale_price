class BecomeSimpleSalePrice < ActiveRecord::Migration[5.1]
  def change
    remove_index :spree_sale_prices, name: 'index_active_sale_prices_for_price'
    remove_index :spree_sale_prices, name: 'index_active_sale_prices_for_all_variants'

    change_column_null :spree_sale_prices, :price_id, false
    change_column_null :spree_sale_prices, :enabled, false

    remove_column :spree_sale_prices, :start_at
    remove_column :spree_sale_prices, :end_at
  end
end
