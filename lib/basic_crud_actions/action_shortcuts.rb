module BasicCrudActions
  module ActsAsCrud
    # mixed in crud controller actions, for a super light controller def!
    module ActionShortcuts
      if RUBY_VERSION >= '2.0.0'
        using BasicCrudActions::ActsAsCrud::SaveReturnsStatusObjects
      else
        require_relative 'legacy_ruby_decorator'
        include BasicCrudActions::ActsAsCrud::LegacyRubyDecorator
      end
      # Adds create action
      module Create
        def create
          set_instance_variable(new_model_source, create_params)
          instance_variable_get(instance_variable_name)
            .save(args_with_context(create_params)).respond
        end
      end

      # Adds destroy action
      module Destroy
        def destroy
          model_source.call(params[:id]).destroy
          redirect_to action: 'index'
        end
      end

      # Adds edit action
      module Edit
        def edit
          find_model
        end
      end

      # Adds index action
      module Index
        def index
          instance_variable_set(instance_variable_name.pluralize,
                                models_source.call)
        end
      end

      # Adds update action
      module Update
        def update
          find_model
          instance_variable_get(instance_variable_name)
            .update_attributes(args_with_context(update_params)).respond
        end
      end

      # Common private methods for controller actions
      module Base
        private

        def find_model
          set_instance_variable(model_source, params[:id])
        end

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

        def set_instance_variable(source, params = {})
          instance_variable_set(instance_variable_name, source.call(params))
        end

        unless RUBY_VERSION >= '2.0.0'
          require_relative 'legacy_ruby_decorator'
          define_method :set_instance_variable do |source, params = {}|
            instance_variable_set(instance_variable_name,
                                  BasicCrudActions::ActsAsCrud::LegacyRubyDecorator::
                                      ResponseDecorator.new(source.call(params)))
          end
        end
      end
    end
  end
end
