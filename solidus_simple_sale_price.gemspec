# encoding: UTF-8
$:.push File.expand_path('../lib', __FILE__)
require 'solidus_simple_sale_price/version'

Gem::Specification.new do |s|
  s.name        = 'solidus_simple_sale_price'
  s.version     = SolidusSimpleSalePrice::VERSION
  s.summary     = 'Adds sale price functionality to Solidus'
  s.description = 'With this plugin its possible to have static sales per product'
  s.license     = 'BSD-3-Clause'

  s.author    = 'Josua Schmid'
  s.email     = 'josua.schmid@renuo.ch'
  s.homepage  = 'http://github.com/renuo/solidus_simple_sale_price'

  s.files = Dir["{app,config,db,lib}/**/*", 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'solidus_core', ['>= 1', '< 3']

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop', '0.54.0'
  s.add_development_dependency 'rubocop-rspec', '1.4.0'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
