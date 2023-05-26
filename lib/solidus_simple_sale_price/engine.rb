require 'solidus_core'
require 'solidus_support'

module SolidusSimpleSalePrice
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_simple_sale_price'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
