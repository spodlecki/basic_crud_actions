require_relative '../lib/basic_crud_actions/acts_as_crud'
require_relative 'basic_crud_actions/response_objects/success'
require_relative 'basic_crud_actions/response_objects/failure'
if RUBY_VERSION >= '2.0.0'
  require_relative 'basic_crud_actions/save_returns_status_objects'
end

# Adds simple, dry, and OO CRUD functionality for Rails Controllers
module BasicCrudActions
end
