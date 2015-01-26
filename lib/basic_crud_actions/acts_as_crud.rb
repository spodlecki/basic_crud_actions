module BasicCrudActions
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
       @class_name ||= self.class.to_s.gsub(/\w+::/, '').gsub('sController', '')
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
