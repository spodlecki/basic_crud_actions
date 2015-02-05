module BasicCrudActions
  # Handles which actions should be created
  module ControllerActions
    SUPPORTED_ACTIONS = [:create, :destroy, :edit, :index, :update]
    def self.to_include(options)
      methods = SUPPORTED_ACTIONS.dup
      options.fetch(:except, []).each do |action|
        methods.delete action
      end
      methods &= options.fetch(:only, SUPPORTED_ACTIONS)
    end
  end
end
