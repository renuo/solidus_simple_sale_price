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

    initializer 'solidus_simple_sale_price.deface_overrides', after: :load_config_initializers do
      root.join('config/overrides').glob('**/*.rb').each { |path| require path }
    end
  end
end
