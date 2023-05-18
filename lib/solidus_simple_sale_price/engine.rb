require 'solidus_core'
require 'solidus_support'

module SolidusSimpleSalePrice
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_simple_sale_price'

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')).sort.each do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
        Rails.autoloaders.main.ignore(c) if Rails.autoloaders.zeitwerk_enabled?
      end
    end

    config.to_prepare(&method(:activate).to_proc)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
