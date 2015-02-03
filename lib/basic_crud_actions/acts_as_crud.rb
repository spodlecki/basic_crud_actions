module BasicCrudActions
  # Adds the Basic Crud functionality to any Rails Controller that
  # is a descendent of ActionController::Base
  module ActsAsCrud
    require_relative '../../lib/examples/flashes_examples'
    extend ActiveSupport::Concern
    extend BasicCrudActions::Examples::FlashesExamples

    # Adds the class macro acts_as_crud to a controller, injecting
    # the BasicCrud methods
    module ClassMethods
      def acts_as_crud(options = {})
        cattr_accessor :acts_as_crud_text_field
        self.acts_as_crud_text_field = (options[:acts_as_crud_text_field] ||
        :acts_as_crud).to_s

        include BasicCrudActions::ActsAsCrud::LocalInstanceMethods
      end
    end

    # Injects the BasicCrud instance methods into a controller
    module LocalInstanceMethods
      def class_name
        @class_name ||= self.class.to_s.gsub(/\w+::/, '').gsub('Controller', '')
                        .singularize
      end

      def model
        @model ||= class_name.constantize
      end
      require_relative 'flashes'
      include BasicCrudActions::ActsAsCrud::Flashes
    end
  end
end

ActionController::Base.send :include, BasicCrudActions::ActsAsCrud
