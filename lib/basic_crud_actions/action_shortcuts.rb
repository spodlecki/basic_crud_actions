module BasicCrudActions
  module ActsAsCrud
    module ActionShortcuts
      using BasicCrudActions::ActsAsCrud::SaveReturnsStatusObjects
      def create
        set_instance_variable(new_model_source, create_params)
        instance_variable_get(instance_variable_name).save(args_with_context).respond
      end

      def edit
        set_instance_variable(model_source, params[:id])
      end

      def index
        instance_variable_set(instance_variable_name.pluralize, models_source.call)
      end

      def update
        set_instance_variable(model_source, params[:id])
        instance_variable_get(instance_variable_name)
          .update_attributes(args_with_context(update_params)).respond
      end

      private

      def instance_variable_name
        "@#{class_name.underscore}"
      end

      def model_source
        model.public_method :find
      end

      def models_source
        model.public_method :all
      end

      def new_model_source
        model.public_method :new
      end

      def set_instance_variable(source, params)
        instance_variable_set(instance_variable_name, source.call(params))
      end
    end
  end
end
