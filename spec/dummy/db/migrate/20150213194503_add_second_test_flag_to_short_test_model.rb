class AddSecondTestFlagToShortTestModel < ActiveRecord::Migration
  def change
    add_column :short_test_models, :second_filter_flag, :boolean
  end
end
