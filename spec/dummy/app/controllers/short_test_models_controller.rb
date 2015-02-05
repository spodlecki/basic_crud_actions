class ShortTestModelsController < ActionController::Base
  acts_as_crud

  private

  def create_params
    params.permit('test')
  end

  def update_params
    create_params
  end
end
