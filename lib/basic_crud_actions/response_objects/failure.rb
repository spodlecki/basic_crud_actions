module BasicCrudActions
  module ResponseObjects
    # Returned by an ActiveRecord object on an unsuccessful save,
    # if that object has the :return_response_objects refinement
    class Failure < SimpleDelegator
      def flash
        failure_flash
      end

      def redirect
        failure_redirect
      end
    end
  end
end
