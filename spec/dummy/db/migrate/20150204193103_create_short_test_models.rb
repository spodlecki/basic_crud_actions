class CreateShortTestModels < ActiveRecord::Migration
  def change
    create_table :short_test_models do |t|

      t.timestamps null: false
    end
  end
end
