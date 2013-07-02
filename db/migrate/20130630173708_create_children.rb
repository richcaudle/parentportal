class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.integer :class_id
      t.string :firstname
      t.string :lastname
      t.datetime :dob
      t.string :picture

      t.timestamps
    end
  end
end
