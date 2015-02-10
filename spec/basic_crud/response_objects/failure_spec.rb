require 'rails_helper'
require_relative '../../../spec/support/respondable_spec'

describe BasicCrudActions::ResponseObjects::Failure do
  describe '.flash' do
    it 'invokes the correct flash method' do
      controller = double
      test_success_object = BasicCrudActions::
          ResponseObjects::Failure.new(controller)
      expect(controller).to receive(:failure_flash)
      test_success_object.flash
    end
  end

  describe '.redirect' do
    it 'redirects to the correct place' do
      controller = double
      test_success_object = BasicCrudActions::
          ResponseObjects::Failure.new(controller)
      expect(controller).to receive(:failure_redirect)
      test_success_object.redirect
    end
  end

  it_should_behave_like 'a Respondable'
end
