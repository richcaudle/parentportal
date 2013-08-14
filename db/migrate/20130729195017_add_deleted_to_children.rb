class AddDeletedToChildren < ActiveRecord::Migration
  def change
    add_column :children, :deleted, :boolean
  end
end
