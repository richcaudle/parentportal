require 'fileutils'

class Child < ActiveRecord::Base
  attr_accessible :class_id, :dob, :firstname, :lastname, :picture, :deleted

  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :dob, :presence => true
  validates :class_id, :presence => true

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :picture, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '400x400>'
  }, :default_url => "/assets/missing-profile-image.jpg"
  
  validates_attachment :picture, :allow_nil => true, :content_type => { :content_type => ['image/jpeg', 'image/jpg', 'image/png'] }, :size => { :in => 0..2048.kilobytes }
  
  def self.can_access_child user_id, child_id

  	# am I a super user?
  	if UserRole.is_superuser(user_id)
  		return true
  	end

  	# TODO: am I an admin user?

  	# Other users
  	my_roles = UserRole.where("user_id = ? AND class_id > -1", user_id)
  	class_ids = my_roles.map {|r| r.school_id}
  	child = Child.where(:id => child_id).first!

  	if !(child.deleted)
  		if class_ids.include? child.class_id
  			return true
  		end
  	end

  	return false

  end

  def self.my_children user_id

  	my_roles = UserRole.where("user_id = ? AND class_id > -1", user_id)

  	# classes I can access
  	class_ids = my_roles.map {|r| r.school_id}
  	
  	Child.where(:class_id => class_ids).where(:deleted => false)  	

  end

end
