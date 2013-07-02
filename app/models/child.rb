class Child < ActiveRecord::Base
  attr_accessible :class_id, :dob, :firstname, :lastname, :picture

  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :dob, :presence => true
  validates :class_id, :presence => true
  
end
