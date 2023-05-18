module Spree
  module VariantDecorator
    def self.prepended(base)
      base.module_eval do
        delegate :on_sale?, :discount_percent, to: :default_price
      end
    end

    def on_sale_in?(currency)
      !!price_in_currency(currency)&.on_sale?
    end

    def sale_price
      default_price.sale_amount
    end

    def original_price
      default_price.original_amount
    end

    def sale_price_in(currency)
      price = price_in_currency(currency)
      Spree::Price.new variant_id: id, currency: currency, amount: price.sale_amount if price
    end

    def original_price_in(currency)
      price = price_in_currency(currency)
      Spree::Price.new variant_id: id, currency: currency, amount: price.original_amount if price
    end

    def discount_percent_in(currency)
      price_in_currency(currency).discount_percent
    end

    def price_in_currency(currency)
      currently_valid_prices.detect { |price| price.currency == currency }
    end

    ::Spree::Variant.prepend self
  end
end
