class AddPictureToEntries < ActiveRecord::Migration
  def self.up
    add_attachment :entries, :picture
  end

  def self.down
    remove_attachment :entries, :picture
  end
end
