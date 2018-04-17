FactoryBot.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'solidus_simple_sale_price/factories'

  factory :sale_price, class: Spree::SalePrice do
    value 10.90
    enabled false
    calculator { Spree::Calculator::FixedAmountSalePriceCalculator.new }
    price

    factory :active_sale_price do
      enabled true
    end
  end

  factory :international_variant, parent: :variant do
    transient do
      price_currencies ['KES', 'UAH', 'AUD']
    end

    after(:create) do |variant, evaluator|
      create_list(:price, evaluator.price_currencies.count, variant: variant)
    end
  end
end
