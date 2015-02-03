module BasicCrudActions
  module ActsAsCrud
    # Refines ActiveRecord models to return a status object on save
    # rather than a boolean
    module SaveReturnsStatusObjects
      refine ActiveRecord::Base do
        def save(controller, *args)
          if super(*args)
            ResponseObjects::Success.new(controller)
          else
            ResponseObjects::Failure.new(controller)
          end
        end

        def save!(controller, *args)
          super(*args)
          ResponseObjects::Success.new(controller)
        end
      end
    end
  end
end
