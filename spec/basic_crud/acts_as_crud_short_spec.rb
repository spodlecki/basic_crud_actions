require 'rails_helper'

def expect_not_to_respond(subject, actions)
  expect_respond(subject, actions, :not_to)
end

def expect_to_respond(subject, actions)
  expect_respond(subject, actions, :to)
end

def expect_respond(subject, actions, verb)
  actions.each do |action|
    expect(subject).public_send(verb, respond_to(action))
  end
end

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
        # New controller for this spec only
        class CustomController < ActionController::Base
          acts_as_crud_verbose model_name: 'foo'
        end
        expect(CustomController.new.class_name).to eq 'foo'
      end
    end

    context 'custom_name is not set' do
      it 'returns the introspective_class_name' do
        # New controller for this spec only
        class CustomController < ActionController::Base
          acts_as_crud_verbose
        end
        test_controller = CustomController.new
        expect(test_controller.class_name)
          .to eq test_controller.send(:introspective_class_name)
      end
    end
  end

  let(:selected_actions) { [:destroy, :edit] }
  let(:unselected_actions) { [:create, :index, :update] }

  describe 'except option' do
    it 'does not respond to any of the eumerated methods' do
      # New controller for this spec only
      class CustomController < ActionController::Base
        acts_as_crud except: [:destroy, :edit]
      end
      subject = CustomController.new
      expect_not_to_respond(subject, selected_actions)
      expect_to_respond(subject, unselected_actions)
    end
  end

  describe 'only option' do
    it 'only responds to the enumerated methods' do
      # New controller for this spec only
      class CustomController2 < ActionController::Base
        acts_as_crud only: [:destroy, :edit]
      end
      subject = CustomController2.new
      expect_to_respond(subject, selected_actions)
      expect_not_to_respond(subject, unselected_actions)
    end
  end

  describe 'model option' do
    context 'option set' do
      it 'sets the model to the correct option' do
        class CustomController3 < ActionController::Base
          acts_as_crud model: ShortTestModel
        end
        expect(CustomController3.new.model).to eq ShortTestModel
      end
    end
    context 'option not set' do
      it 'sets the model to the introspected option' do
        expect(described_class.new.model).to eq ShortTestModel
      end
    end
  end

  describe '.create' do
    subject { post :create, test: {} }
    before { subject }
    it 'sets the proper ivar' do
      if RUBY_VERSION >= '2.0.0'
        expect(assigns(:short_test_model)).to be_a_kind_of ShortTestModel
      else
        expect(assigns(:short_test_model))
          .to be_a_kind_of BasicCrudActions::ActsAsCrud::LegacyRubyDecorator::
                               ResponseDecorator
      end
    end

    it 'invokes the correct response' do
      expect(response)
        .to redirect_to edit_short_test_model_path(ShortTestModel.last.id)
    end
  end

  let(:model) { ShortTestModel.create }
  describe '.update' do
    subject { post :update, id: model.id }
    before { subject }
    it 'sets the proper ivar' do
      if RUBY_VERSION >= '2.0.0'
        expect(assigns(:short_test_model)).to be_a_kind_of ShortTestModel
      else
        expect(assigns(:short_test_model))
          .to be_a_kind_of BasicCrudActions::ActsAsCrud::LegacyRubyDecorator::
                               ResponseDecorator
      end
    end

    it 'invokes the correct response' do
      expect(response)
        .to redirect_to edit_short_test_model_path(ShortTestModel.last.id)
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

  describe '.new' do
    it 'gives a new version of the model to the view' do
      get :new
      expect(assigns(:short_test_model)).to be_a_kind_of ShortTestModel
    end

    it 'renders new' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe '.destroy' do
    it 'destroys the correct model' do
      model
      expect { delete :destroy, id: model.id }
        .to change { ShortTestModel.count }.by(-1)
      expect { ShortTestModel.find(model.id) }.to raise_exception
    end

    it 'redirects to index' do
      delete :destroy, id: model.id
      expect(response).to redirect_to short_test_models_path
    end
  end

end
