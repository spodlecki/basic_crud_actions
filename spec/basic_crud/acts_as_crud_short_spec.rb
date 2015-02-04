require 'rails_helper'

describe ShortTestModelsController, type: :controller do
  render_views
  describe '#basic_crud_actions' do
    context 'TestModelsController' do
      it 'names the action acts_as_crud' do
        expect(described_class.acts_as_crud_text_field).to eq 'acts_as_crud'
      end
    end

    context 'SecondTestsController (has acts_as_crud already' do
      it 'names the action crud_actions' do
        expect(SecondTestsController.acts_as_crud_text_field)
          .to eq 'crud_actions'
      end
    end
  end

  describe '.class name' do
    context 'custom_name is set' do
      it 'returns the custom name' do
        class CustomController < ActionController::Base
          acts_as_crud_verbose model_name: 'foo'
        end
        expect(CustomController.new.class_name).to eq 'foo'
      end
    end

    context 'custom_name is not set' do
      it 'returns the introspective_class_name' do
        class CustomController < ActionController::Base
          acts_as_crud_verbose
        end
        test_controller = CustomController.new
        expect(test_controller.class_name)
          .to eq test_controller.send(:introspective_class_name)
      end
    end
  end

  describe '.create' do
    subject { post :create, test: {} }
    before { subject }
    it 'sets the proper ivar' do
      expect(assigns(:short_test_model)).to be_a_kind_of ShortTestModel
    end

    it 'invokes the correct response' do
      expect(response).to redirect_to edit_short_test_model_path(ShortTestModel.last.id)
    end
  end

  let(:model) { ShortTestModel.create }
  describe '.update' do
    subject { post :update, id: model.id }
    before { subject }
    it 'sets the proper ivar' do
      expect(assigns(:short_test_model)).to be_a_kind_of ShortTestModel
    end

    it 'invokes the correct response' do
      expect(response).to redirect_to edit_short_test_model_path(ShortTestModel.last.id)
    end
  end

  describe '.edit' do
    it 'sets the proper ivar' do
      get :edit, id: model.id
      expect(assigns(:short_test_model)).to eq model
    end

    it 'renders edit' do
      get :edit, id: model.id
      expect(response).to render_template 'edit'
    end
  end

  describe '.index' do
    it 'pulls in all of the models' do
      2.times do
        ShortTestModel.create
      end
      get :index
      expect(assigns(:short_test_models)).to eq ShortTestModel.all
    end

    it 'renders index' do
      get :index
      expect(response).to render_template 'index'
    end
  end
end
