module BasicCrudActions
  module Examples
    # RSpec shared examples to make sure success_flash and failure_flash
    # are working as intended.
    module FlashesExamples
      if Rails.env.test?
        require 'rspec'

        ::RSpec.shared_examples 'basic_crud success flashes' do
          it 'should set the notice flash to the appropriate value' do
            subject
            expect(flash[:notice]).to eq "#{controller.class_name}"\
        " was successfully #{controller.action_name}d"
          end
        end

        ::RSpec.shared_examples 'basic_crud failure flashes' do
          it 'should set the error flash to the appropriate value' do
            subject
            expect(flash[:error]).to eq "Could not #{controller.action_name}"\
        " #{controller.class_name}"
          end
        end

        ::RSpec.shared_examples 'basic_crud create' do
          it 'should set an instance variable with the proper model name' do
            subject
            correct_class = model.class
            expect(assigns(correct_class.name.underscore)).to be_a_kind_of correct_class
          end

          it 'should save the model' do
            expect { subject }.to change { controller.model.count }.by 1
          end

          it 'should call response on the result of .save' do
            mock_model = double
            allow(controller.model).to receive(:new).and_return(mock_model)
            mock_response_obj = double
            allow(mock_model).to receive(:save).and_return(mock_response_obj)
            allow(controller).to receive(:render)
            expect(mock_response_obj).to receive(:respond)
            subject
          end
        end

        ::RSpec.shared_examples 'basic_crud destroy' do
          let(:mock_model) { double(Object, destroy: nil) }
          it_behaves_like 'find_model'

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

        ::RSpec.shared_examples 'basic_crud edit' do
          it 'pulls the correct model' do
            subject
            expect(assigns(controller.model.name.underscore)).to be_a_kind_of controller.model
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
            expect(assigns(controller.model.name.underscore)).to be_a_kind_of controller.model
          end
        end

        ::RSpec.shared_examples 'basic_crud update' do
          include_examples 'find_model'
          let(:mock_model) { double(Object, destroy: nil) }
          xit 'should update the model' do
            subject
          end
        end

        ::RSpec.shared_examples 'find_model' do
          let(:mock_model) { double(Object, destroy: nil) }
          xit 'pulls the correct model' do
            expect(controller.model).to receive(:find).and_return(mock_model)
            subject
          end
        end
      end
    end
  end
end
