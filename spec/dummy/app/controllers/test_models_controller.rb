class TestModelsController < ApplicationController
  using BasicCrudActions::ActsAsCrud::SaveReturnsStatusObjects
  acts_as_crud

  def create
    @test_save = TestModel.new.save(args_with_context)
    @test_save.respond
  end

  def create_fail
    def action_name
      'create'
    end
    @test_save = BasicCrudActions::ResponseObjects::Failure.new(self)
    @test_save.respond
  end

  def update
    model = TestModel.find params[:id]
    @test_save = model.update_attributes(args_with_context(id: model.id + 1))
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
    @test_save = TestModel.new.save(args_with_context)
    render nothing: true
  end

  def test_save_bang
    @test_save = TestModel.new.save!(args_with_context)
    render nothing: true
  end

  def test_save_invalid
    first_model = TestModel.create
    @test_save = TestModel.new(id: first_model.id).save(args_with_context)
    render nothing: true
  end

  def test_save_bang_invalid
    first_model = TestModel.create
    @test_save = TestModel.new(id: first_model.id).save!(args_with_context)
    render nothing: true
  end
end
