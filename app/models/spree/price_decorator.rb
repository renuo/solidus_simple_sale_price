Spree::Price.class_eval do
  def original_amount
    self[:amount]
  end

  def original_amount=(value)
    self[:amount] = Spree::LocalizedNumber.parse(value)
  end

  def on_sale?
    sale_amount.present? && original_amount.present? && sale_amount < original_amount
  end

  def amount
    on_sale? ? sale_amount : original_amount
  end

  def price
    amount
  end

  def discount_percent
    return 0.0 unless original_amount.positive?
    return 0.0 unless on_sale?

    (1 - (sale_amount / original_amount)) * 100.0
  end
end
