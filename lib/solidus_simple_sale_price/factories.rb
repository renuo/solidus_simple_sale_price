FactoryBot.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'solidus_simple_sale_price/factories'

  factory :price_on_sale, parent: :price do
    sale_amount 10.90
  end

  factory :international_variant, parent: :variant do
    transient do
      price_currencies %w[KES UAH AUD]
    end

    after(:create) do |variant, evaluator|
      evaluator.price_currencies.each do |currency|
        create(:price, variant: variant, currency: currency)
      end
    end
  end
end
