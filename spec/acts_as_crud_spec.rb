require 'rails_helper'

describe TestsController, type: :controller do
  describe '#basic_crud_actions' do
    context 'TestsController' do
      it 'names the action acts_as_crud' do
        expect(described_class.acts_as_crud_text_field).to eq 'acts_as_crud'
      end
    end

    context 'SecondTestsController (has acts_as_crud already' do
      it 'names the action crud_actions' do
        expect(SecondTestsController.acts_as_crud_text_field).to eq 'crud_actions'
      end
    end
  end

  describe '.success_flash' do
    context '.create' do
      it 'should set the notice flash to the appropriate value' do
        post :create
        expect(flash[:notice]).to eq 'Test was successfully created'
      end
    end

    context '.update' do
      it 'should set the notice flash to the appropriate value' do
        put :update
        expect(flash[:notice]).to eq 'Test was successfully updated'
      end
    end
  end

  describe '.failure_flash' do
    context '.create' do
      it 'should set the notice flash to the appropriate value' do
        get :create_fail
        # the message is 'create_fail' because that's the quick controller action
        # testing the method
        expect(flash[:error]).to eq 'Could not create_fail Test'
      end
    end

    context '.create' do
      it 'should set the notice flash to the appropriate value' do
        get :update_fail
        # the message is 'update_fail' because that's the quick controller action
        # testing the method
        expect(flash[:error]).to eq 'Could not update_fail Test'
      end
    end
  end
end
