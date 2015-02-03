class TestModelsController < ApplicationController
  using BasicCrudActions::ActsAsCrud::SaveReturnsStatusObjects
  acts_as_crud

  def create
    success_flash
    render nothing: true
  end

  def create_fail
    failure_flash
    render nothing: true
  end

  def update
    success_flash
    render nothing: true
  end

  def update_fail
    failure_flash
    render nothing: true
  end

  def test_save
    @test_save = TestModel.new.save(self)
    render nothing: true
  end

  def test_save_bang
    @test_save = TestModel.new.save!(self)
    render nothing: true
  end

  def test_save_invalid
    first_model = TestModel.create
    @test_save = TestModel.new(id: first_model.id).save(self)
    render nothing: true
  end

  def test_save_bang_invalid
    first_model = TestModel.create
    @test_save = TestModel.new(id: first_model.id).save!(self)
    render nothing: true
  end
end
