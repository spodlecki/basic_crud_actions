class ShortTestModelsController < ActionController::Base
  acts_as_crud

  ## These are for unit tests only ##

  def test_save
    @test_save = new_test_model_source.call.save(args_with_context)
    render nothing: true
  end

  def test_save_bang
    @test_save = new_test_model_source.call.save!(args_with_context)
    render nothing: true
  end

  def test_save_invalid
    first_model = TestModel.create
    @test_save = new_test_model_source.call(id: first_model.id).save(args_with_context)
    render nothing: true
  end

  def test_save_bang_invalid
    first_model = TestModel.create
    @test_save = new_test_model_source.call(id: first_model.id).save!(args_with_context)
    render nothing: true
  end

  private

  def create_params
    params.permit('test')
  end

  def update_params
    create_params
  end
end
