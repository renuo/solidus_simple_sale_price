Spree::Variant.class_eval do
  delegate :on_sale?, :discount_percent, to: :default_price

  def on_sale_in?(currency)
    price_in(currency).on_sale?
  end

  def sale_price
    default_price.sale_amount
  end

  def original_price
    default_price.original_amount
  end

  def sale_price_in(currency)
    Spree::Price.new variant_id: id, currency: currency, amount: price_in(currency).sale_amount
  end

  def original_price_in(currency)
    Spree::Price.new variant_id: id, currency: currency, amount: price_in(currency).original_amount
  end

  def discount_percent_in(currency)
    price_in(currency).discount_percent
  end
end
