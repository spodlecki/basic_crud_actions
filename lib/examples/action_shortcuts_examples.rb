module BasicCrudActions
  module Examples
    # RSpec shared examples to make sure success_flash and failure_flash
    # are working as intended.
    module ActionShortcutsExamples
      if Rails.env.test?
        require 'rspec'
        require_relative 'create_examples'
        require_relative 'destroy_examples'
        require_relative 'flashes_examples'
        include ::BasicCrudActions::Examples::CreateExamples
        include ::BasicCrudActions::Examples::DestroyExamples
        include ::BasicCrudActions::Examples::FlashesExamples

        ::RSpec.shared_examples 'basic_crud edit' do
          it 'pulls the correct model' do
            subject
            expect(assigns(controller.send(:instance_variable_name)
                             .gsub('@', ''))).to be_a_kind_of controller.model
          end
        end

        ::RSpec.shared_examples 'basic_crud index' do
          it 'pulls all of the correct model' do
            expect(controller.model).to receive :all
            subject
          end
        end

        ::RSpec.shared_examples 'basic_crud new' do
          it 'pulls a new version of the correct model' do
            subject
            expect(assigns(controller.send(:instance_variable_name)
                             .gsub('@', ''))).to be_a_kind_of controller.model
          end
        end

        ::RSpec.shared_examples 'basic_crud update' do
          let(:mock_model) { double(Object, destroy: nil) }
          it 'should update the model' do
            mock_model = double
            mock_method = double

            expect(mock_model).to receive(:id) { model.id }
            expect(controller).to receive(:model_source).and_return(mock_method)
            expect(mock_method).to receive(:call).with(model.id.to_s)
              .and_return(mock_model)
            expect(mock_model).to receive(:update_attributes)
              .and_return BasicCrudActions::ResponseObjects::Success
              .new(controller)
            subject
          end
        end
      end
    end
  end
end
