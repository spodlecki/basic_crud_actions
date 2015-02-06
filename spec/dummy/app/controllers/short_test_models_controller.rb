class ShortTestModelsController < ActionController::Base
  acts_as_crud

  ## These are for unit tests only ##
  if RUBY_VERSION >= '2.0.0'
    using BasicCrudActions::ActsAsCrud::SaveReturnsStatusObjects
  end
  def test_save
    set_instance_variable(new_model_source)
    instance_variable_set(:@test_result, instance_variable_get(instance_variable_name).save(args_with_context))
    render nothing: true
  end

  def test_save_bang
    @test_save = new_model_source.call.save!(args_with_context)
    render nothing: true
  end

  def test_save_invalid
    first_model = ShortTestModel.create
    @test_save = model_source.call(first_model.id).save(args_with_context)
    render nothing: true
  end

  def test_save_bang_invalid
    first_model = ShortTestModel.create
    @test_save = model_source.call(id: first_model.id).save!(args_with_context)
    render nothing: true
  end

  def create_fail
    @test_save = BasicCrudActions::ResponseObjects::Failure.new(self)
    @test_save.respond
  end

  def update_fail
    @test_save = BasicCrudActions::ResponseObjects::Failure.new(self)
    @test_save.respond
  end

  private

  def create_params
    params.permit('test')
  end

  def update_params
    create_params
  end
end
