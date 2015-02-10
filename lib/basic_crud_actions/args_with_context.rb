module BasicCrudActions
  # Bundling a set of arguments with its invoking context
  class ArgsWithContext
    attr_accessor :context, :args
    def initialize(controller, *args)
      @context = controller
      @args = *args
    end
  end
end
