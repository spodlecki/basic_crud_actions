module BasicCrudActions
  # Adds the Basic Crud functionality to any Rails Controller that
  # is a descendent of ActionController::Base
  module ActsAsCrud
    require_relative '../../lib/examples/action_shortcuts_examples'
    require_relative 'args_with_context'
    require_relative 'controller_actions'
    extend ActiveSupport::Concern

    # Adds the class macro acts_as_crud to a controller, injecting
    # the BasicCrud methods
    module ClassMethods
      def acts_as_crud_verbose(options = {})
        cattr_accessor :acts_as_crud_text_field
        self.acts_as_crud_text_field = options.fetch(:acts_as_crud_text_field,
                                                     :acts_as_crud_verbose).to_s

        extend BasicCrudActions::Examples::ActionShortcutsExamples
        # Put methods that need access to the options hash here:
        # use define_method for closures!
        create_class_name(options)
        create_model_assoc(options)

        include BasicCrudActions::ActsAsCrud::LocalInstanceMethods
      end

      def acts_as_crud(options = {})
        cattr_accessor :acts_as_crud_text_field
        self.acts_as_crud_text_field = options.fetch(:acts_as_crud_text_field,
                                                     :acts_as_crud).to_s

        # Put methods that need access to the options hash here:
        # use #define_method for closures!
        create_model_assoc(options)
        create_class_name(options)

        include_actions(BasicCrudActions::ControllerActions.to_include(options))
      end

      private

      def create_class_name(options)
        define_method :class_name do
          @class_name ||= options.fetch(:model_name, nil) ||
                          introspective_class_name
        end
      end

      def create_model_assoc(options)
        define_method :model do
          @model ||= options.fetch(:model, nil) ||
                     introspective_class_name.constantize
        end
      end

      def include_actions(methods)
        require_relative 'action_shortcuts'
        include BasicCrudActions::ActsAsCrud::ActionShortcuts::Base
        methods.each do |method|
          include(('BasicCrudActions::ActsAsCrud::ActionShortcuts::' +
                    method.to_s.capitalize).constantize)
        end
        include BasicCrudActions::ActsAsCrud::LocalInstanceMethods
      end
    end

    # Injects the BasicCrud instance methods into a controller
    module LocalInstanceMethods
      def args_with_context(*args)
        BasicCrudActions::ArgsWithContext.new(self, *args)
      end

      require_relative 'flashes'
      include BasicCrudActions::ActsAsCrud::Flashes
      require_relative 'redirects'
      include BasicCrudActions::ActsAsCrud::Redirects

      private

      def introspective_class_name
        @model ? @model.to_s : self.class.to_s.gsub(/\w+::/, '')
          .gsub('Controller', '').singularize
      end
    end
  end
end

ActionController::Base.send :include, BasicCrudActions::ActsAsCrud
