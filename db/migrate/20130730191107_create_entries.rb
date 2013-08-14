class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :child_id
      t.integer :entry_type_id
      t.integer :order
      t.string :text
      t.string :image
      t.boolean :deleted

      t.timestamps
    end
  end
end
