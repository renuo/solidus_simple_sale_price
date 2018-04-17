module Spree
  class SalePrice < ActiveRecord::Base

    belongs_to :price, class_name: "Spree::Price"
    delegate :currency, to: :price

    has_one :variant, through: :price

    has_one :calculator, class_name: "Spree::Calculator", as: :calculable, dependent: :destroy
    validates :calculator, presence: true
    accepts_nested_attributes_for :calculator

    scope :active, -> { where(enabled: true) }

    before_destroy :touch_product
    # TODO make this work or remove it
    #def self.calculators
    #  Rails.application.config.spree.calculators.send(self.to_s.tableize.gsub('/', '_').sub('spree_', ''))
    #end

    def calculator_type
      calculator.class.to_s if calculator
    end

    def calculated_price
      calculator.compute self
    end

    def enable
      update_attribute(:enabled, true)
    end

    def disable
      update_attribute(:enabled, false)
    end

    def active?
      Spree::SalePrice.active.include? self
    end

    def start
      update_attributes(enabled: true)
    end

    def stop
      update_attributes(enabled: false)
    end

    # Convenience method for displaying the price of a given sale_price in the table
    def display_price
      Spree::Money.new(value || 0, { currency: price.currency })
    end

    protected
      def touch_product
        self.variant.product.touch
      end

  end
end
