require 'rails_helper'

describe TestModelsController, type: :controller do
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

  describe '.success_flash' do
    context '.create' do
      it_behaves_like 'basic_crud success flashes' do
        let(:action) { post :create }
      end
    end

    context '.update' do
      it_behaves_like 'basic_crud success flashes' do
        let(:action) { post :update }
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
