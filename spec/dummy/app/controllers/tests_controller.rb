class TestsController < ApplicationController
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
end
