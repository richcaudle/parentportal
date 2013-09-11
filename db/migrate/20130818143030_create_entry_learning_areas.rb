class CreateEntryLearningAreas < ActiveRecord::Migration
  def change
    create_table :entry_learning_areas do |t|
      t.integer :entry_id
      t.integer :learning_area_id

      t.timestamps
    end
  end
end
