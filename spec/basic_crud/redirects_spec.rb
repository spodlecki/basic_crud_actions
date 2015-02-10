require 'rails_helper'

describe ShortTestModelsController, type: :controller do
  render_views
  describe '.success_redirect' do
    context 'create action' do
      it 'redirects to the proper path' do
        post :create, test: {}
        expect(response).to redirect_to edit_short_test_model_path(ShortTestModel.last.id)
      end
    end

    context 'update action' do
      it 'redirects to the proper path' do
        model = ShortTestModel.create
        get :update, id: model.id, test: {}
        expect(response).to redirect_to edit_short_test_model_path(ShortTestModel.last.id)
      end
    end
  end

  describe '.failure_redirect' do
    context 'create action' do
      it 'renders new' do
        expect(controller).to receive(:render).with(:new).and_call_original
        allow(controller).to receive(:action_name).and_return('create')
        post :create_fail
      end
    end

    context 'update action' do
      it 'renders edit' do
        expect(controller).to receive(:render).with(:edit).and_call_original
        allow(controller).to receive(:action_name).and_return('update')
        post :update_fail
      end
    end
  end
end
