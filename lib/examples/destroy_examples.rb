module BasicCrudActions
  module Examples
    module DestroyExamples
      ::RSpec.shared_examples 'basic_crud destroy' do
        let(:mock_model) { double(Object, destroy: nil) }

        it 'pulls the correct model' do
          expect(controller.model).to receive(:find).and_return(mock_model)
          subject
        end

        it 'calls destroy on the model' do
          allow(controller.model).to receive(:find).and_return(mock_model)
          expect(mock_model).to receive :destroy
          subject
        end
      end
    end
  end
end
