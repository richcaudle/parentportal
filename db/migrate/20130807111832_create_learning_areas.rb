class CreateLearningAreas < ActiveRecord::Migration
  def change
    create_table :learning_areas do |t|
      t.string :name

      t.timestamps
    end
  end
end
