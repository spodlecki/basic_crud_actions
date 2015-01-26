$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "basic_crud_actions/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'basic_crud_actions'
  s.version     = BasicCrudActions::VERSION
  s.authors     = ['SK Intertainment Inc']
  s.email       = ['contact.skintertainment.com']
  s.homepage    = 'http://skintertainment.com'
  s.summary     = 'Adds basic CRUD-type controller actions to avoid duplication'
  #s.description = 'TODO: Description of ActsAsCrud.'
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 3.2.0"

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-spork'
  s.add_development_dependency 'geminabox'
end
