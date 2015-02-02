module BasicCrudActions
  module ActsAsCrud
    # Adds boilerplate flashes on success and failure
    module Flashes
      def failure_flash
        flash[:error] = "Could not #{action_name} #{class_name}"
      end

      def success_flash
        flash[:notice] = "#{class_name} was successfully #{action_name}d"
      end
    end
  end
end
