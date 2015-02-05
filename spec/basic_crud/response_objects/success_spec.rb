require 'rails_helper'
require_relative '../../../spec/support/respondable_spec'

describe BasicCrudActions::ResponseObjects::Success do
  let(:controller) { double }
  let(:test_success_object) do
    BasicCrudActions::ResponseObjects::Success.new(controller)
  end

  describe '.flash' do
    it 'invokes the correct flash method' do
      expect(controller).to receive(:success_flash)
      test_success_object.flash
    end
  end
  describe '.redirect' do
    it 'redirects to the correct place' do
      expect(controller).to receive(:success_redirect)
      test_success_object.redirect
    end
  end
  it_should_behave_like 'a Respondable'
end
