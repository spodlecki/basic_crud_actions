$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "basic_crud_actions/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'basic_crud_actions'
  s.version     = BasicCrudActions::VERSION
  s.authors     = ['Matthew Rieger']
  s.email       = ['matthew.rieger@gmail.com']
  s.homepage    = 'http://skintertainment.com'
  WORDS_ABOUT_GEM = 'Adds basic CRUD-type controller actions to avoid duplication'
  s.summary     = WORDS_ABOUT_GEM
  s.description = WORDS_ABOUT_GEM
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.2.0"

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-spork'
  s.add_development_dependency 'geminabox'
end
