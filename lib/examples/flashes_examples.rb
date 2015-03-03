module BasicCrudActions
  module Examples
    module FlashesExamples
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
    end
  end
end
