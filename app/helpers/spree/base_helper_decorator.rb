Spree::BaseHelper.class_eval do
  def display_original_price(product_or_variant)
    product_or_variant.original_price_in(current_currency).display_price.to_html
  end

  def display_discount_percent(product_or_variant, append_text = 'Off')
    discount = product_or_variant.discount_percent_in current_currency

    if discount.positive?
      "#{number_to_percentage(discount, precision: 0)} #{append_text}"
    else
      ''
    end
  end
end
