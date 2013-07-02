class CreateSchoolClasses < ActiveRecord::Migration
  def change
    create_table :school_classes do |t|
      t.string :name
      t.string :picture
      t.integer :school_id

      t.timestamps
    end
  end
end
