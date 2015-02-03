require 'rails_helper'

describe TestModelsController, type: :controller do
  render_views
  describe '.success_redirect' do
    context 'create action' do
      it 'redirects to the proper path' do
        get :create
        expect(response).to redirect_to edit_test_model_path(TestModel.last.id)
      end
    end

    context 'update action' do
      it 'redirects to the proper path' do
        model = TestModel.create
        get :update, id: model.id
        expect(response).to redirect_to edit_test_model_path(TestModel.last.id)
      end
    end
  end

  describe '.failure_redirect' do
    context 'create action' do
      it 'renders new' do
        expect(controller).to receive(:render).with(:new).and_call_original
        post :create_fail
      end
    end

    context 'update action' do
      it 'renders edit' do
        expect(controller).to receive(:render).with(:edit).and_call_original
        post :update_fail
      end
    end
  end
end
