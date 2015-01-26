class SecondTestsController < ApplicationController
  acts_as_crud acts_as_crud_text_field: :crud_actions
end
