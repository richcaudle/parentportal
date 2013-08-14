class AmendChildPicture < ActiveRecord::Migration
  def self.up
  	remove_column :children, :picture
    add_attachment :children, :picture
  end

  def self.down
    remove_attachment :children, :picture
    add_column :children, :picture
  end
end
