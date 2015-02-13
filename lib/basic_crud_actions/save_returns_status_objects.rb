module BasicCrudActions
  module ActsAsCrud
    # Refines ActiveRecord models to return a status object on save
    # rather than a boolean
    module SaveReturnsStatusObjects
      refine ActiveRecord::Base do
        def save(args_with_context)
          context = args_with_context.context
          if super(*args_with_context.args)
            success_obj(context)
          else
            failure_obj(context)
          end
        end

        def save!(args_with_context)
          super(*args_with_context.args)
          success_obj(args_with_context.context)
        end

        def update_attributes(args_with_context)
          context = args_with_context.context
          if super(*args_with_context.args)
            success_obj(context)
          else
            failure_obj(context)
          end
        end

        def update_attributes!(args_with_context)
          super(*args_with_context.args)
          success_obj(args_with_context.context)
        end

        private

        def failure_obj(controller)
          ResponseObjects::Failure.new(controller)
        end

        def success_obj(controller)
          ResponseObjects::Success.new(controller)
        end
      end

      refine ActiveRecord::Relation do
        def filter(args = {}, &block)
          return instance_eval(&block).filter(args) if block_given?
          key = args.keys.first
          val = args.delete(key)
          key ? where(key => val).filter(args) : self
        end
      end
    end
  end
end
