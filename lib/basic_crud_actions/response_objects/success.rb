module BasicCrudActions
  module ResponseObjects
    # Returned by an ActiveRecord object on a successful save,
    # if that object has the :return_response_objects refinement
    class Success < SimpleDelegator
      def flash
        success_flash
      end

      def redirect
        success_redirect
      end
    end
  end
end
