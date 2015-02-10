# Adds a convenience method calling both flash and redirect.
# This is primarily intended to DRY up controller actions
module Respondable
  def respond
    flash
    redirect
  end
end
