require 'rails_helper'

def expect_success_object
  expect(assigns(:test_save))
    .to be_a_kind_of BasicCrudActions::ResponseObjects::Success
end
if RUBY_VERSION >= '2.0.0'
  describe ShortTestModelsController, type: :controller do
    describe '.save' do
      context 'valid params' do
        it 'returns a success object' do
          get :test_save
          expect_success_object
        end
      end

      context 'invald_params' do
        it 'returns a failure object' do
          get :test_save_invalid
          expect(assigns(:test_save))
            .to be_a_kind_of BasicCrudActions::ResponseObjects::Failure
        end
      end
    end

    describe '.save!' do
      context 'valid params' do
        it 'returns a success object' do
          get :test_save_bang
          expect_success_object
        end
      end
      context 'invalid params' do
        it 'raises' do
          expect { get :test_save_bang_invalid }.to raise_exception
        end
      end
    end

    describe '.update_attributes' do
      context 'valid params' do
        it 'returns a success object' do
          model = ShortTestModel.create
          get :update, id: model.id
          expect_success_object
        end
      end
    end
  end
end
