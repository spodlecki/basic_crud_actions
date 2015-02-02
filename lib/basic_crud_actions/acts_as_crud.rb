module BasicCrudActions

  if Rails.env == 'test'
    require 'rspec'
    ::RSpec.shared_examples 'basic_crud success flashes' do
      it 'should set the notice flash to the appropriate value' do
        action
        expect(flash[:notice]).to eq "#{controller.class_name}"\
        " was successfully #{controller.action_name}d"
      end
    end

    ::RSpec.shared_examples 'basic_crud failure flashes' do
      it 'should set the error flash to the appropriate value' do
        action
        expect(flash[:error]).to eq "Could not #{controller.action_name}"\
        " #{controller.class_name}"
      end
    end
  end

  module ActsAsCrud
    extend ActiveSupport::Concern


    included do
    end


    module ClassMethods
      def acts_as_crud(options = {})
        cattr_accessor :acts_as_crud_text_field
        self.acts_as_crud_text_field = (options[:acts_as_crud_text_field] ||
        :acts_as_crud).to_s

        include BasicCrudActions::ActsAsCrud::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods

      def class_name
       @class_name ||= self.class.to_s.gsub(/\w+::/, '').gsub('Controller', '')
                         .singularize
      end

      def failure_flash
        flash[:error] = "Could not #{action_name} #{class_name}"
      end

      def success_flash
        flash[:notice] = "#{class_name} was successfully #{action_name}d"
      end
    end
  end
end

ActionController::Base.send :include, BasicCrudActions::ActsAsCrud
