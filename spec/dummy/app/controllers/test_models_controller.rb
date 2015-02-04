class TestModelsController < ApplicationController
  using BasicCrudActions::ActsAsCrud::SaveReturnsStatusObjects
  acts_as_crud_verbose

  ### These are the types of actions you will see in an acts_as_crud ###
  ### generated controller.                                          ###
  def create
    @test_save = new_test_model_source.call.save(args_with_context)
    @test_save.respond
  end

  def edit
    @test_save = find_model
  end

  def index
    @test_saves = test_models_source.call
  end

  def new
    @test_save = new_test_model_source.call
  end

  def update
    model = test_model_source.call params[:id]
    @test_save = model.update_attributes(args_with_context(id: model.id + 1))
    @test_save.respond
  end

  ## These are for unit tests only ##

  def create_fail
    def action_name
      'create'
    end
    @test_save = BasicCrudActions::ResponseObjects::Failure.new(self)
    @test_save.respond
  end

  def update_fail
    def action_name
      'update'
    end
    @test_save = BasicCrudActions::ResponseObjects::Failure.new(self)
    @test_save.respond
  end

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

  def find_model
    test_model_source.call params[:id]
  end

  def test_model_source
    TestModel.public_method :find
  end

  def test_models_source
    TestModel.public_method :all
  end

  def new_test_model_source
    TestModel.public_method :new
  end
end
