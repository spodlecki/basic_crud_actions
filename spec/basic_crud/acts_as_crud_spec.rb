require 'rails_helper'

describe TestModelsController, type: :controller do
  before { allow(controller).to receive(:render) }
  describe '#basic_crud_actions' do
    context 'TestModelsController' do
      it 'names the action acts_as_crud_verbose' do
        expect(described_class.acts_as_crud_text_field).to eq 'acts_as_crud_verbose'
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
  describe '.success_flash' do
    context '.create' do
      it_behaves_like 'basic_crud success flashes' do
        let(:action) { post :create }
      end
    end

    context '.update' do
      it_behaves_like 'basic_crud success flashes' do
        let(:model) { TestModel.create }
        let(:action) { post :update, id: model.id }
      end
    end
  end

  describe '.failure_flash' do
    it_behaves_like 'basic_crud failure flashes' do
      let(:action) { get :create_fail }
    end

    context '.create' do
      it_behaves_like 'basic_crud failure flashes' do
        let(:action) { get :update_fail }
      end
    end
  end
end
