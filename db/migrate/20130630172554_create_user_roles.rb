class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.integer :user_id
      t.integer :school_id
      t.integer :class_id
      t.integer :child_id
      t.integer :role_id

      t.timestamps
    end
  end
end
