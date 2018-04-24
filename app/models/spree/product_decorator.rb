Spree::Product.class_eval do
  delegate :on_sale_in?, :sale_price_in, :original_price_in, :discount_percent_in,
           :on_sale?, :sale_price, :original_price, :discount_percent, to: :master
end
