class Entry < ActiveRecord::Base
  belongs_to :entry_type

  attr_accessible :child_id, :deleted, :entry_type_id, :image, :order, :text, :picture
  validates :entry_type_id, :presence => true

  has_attached_file :picture, styles: {
    thumb: '80x60>',
    square: '200x150#',
    medium: '800x600>'
  }

  validates_attachment :picture, :allow_nil => true, :content_type => { :content_type => ['image/jpeg', 'image/jpg', 'image/png'] }, :size => { :in => 0..2048.kilobytes }

end
