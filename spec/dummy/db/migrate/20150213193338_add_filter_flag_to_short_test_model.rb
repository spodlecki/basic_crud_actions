class AddFilterFlagToShortTestModel < ActiveRecord::Migration
  def change
    add_column :short_test_models, :filter_flag, :boolean
  end
end
