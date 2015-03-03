module BasicCrudActions
  module Examples
    module CreateExamples
      ::RSpec.shared_examples 'basic_crud create' do
        it 'should set an instance variable with the proper model name' do
          subject
          correct_class = controller.model
          expect(assigns(controller.send(:instance_variable_name)
                           .gsub('@', ''))).to be_a_kind_of correct_class
        end

        it 'should save the model' do
          expect { subject }.to change { controller.model.count }.by 1
        end

        it 'should call response on the result of .save' do
          mock_model = double.as_null_object
          allow(controller.model).to receive(:new).and_return(mock_model)
          mock_response_obj = double
          allow(mock_model).to receive(:save).and_return(mock_response_obj)
          allow(controller).to receive(:render)
          expect(mock_response_obj).to receive(:respond)
          subject
        end
      end
    end
  end
end
