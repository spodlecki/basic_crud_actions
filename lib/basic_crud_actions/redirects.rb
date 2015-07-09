module BasicCrudActions
  module ActsAsCrud
    # Common methods for redirecting. Included in the controller, but
    # used in its delegator Success and Failure objects.
    module Redirects
      def success_redirect
        instance = instance_variable_get(instance_variable_name)
        redirect_to action: 'edit', id: instance.id, status: 303
      end

      def failure_redirect
        case action_name.to_sym
        when :create
          action = :new
        when :update
          action = :edit
        else
          fail 'cannot use failure_redirect with actions other than'\
          ' create or update'
        end
        render action
      end
    end
  end
end
