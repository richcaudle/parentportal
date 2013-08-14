require 'fileutils'

class Child < ActiveRecord::Base
  attr_accessible :class_id, :dob, :firstname, :lastname, :picture, :deleted

  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :dob, :presence => true
  validates :class_id, :presence => true
  validates_format_of :picture, :with => /\.(jpeg|jpg|png)$/i, :allow_nil => true, :message => "Please choose a PNG or JPG file"
  
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

  def self.save_picture child_id, picture
    file_name = 'profile' + File.extname(picture.original_filename)
    path = Rails.root.join('public', 'uploads', 'children', child_id.to_s, file_name)
    dir = File.dirname(path)

    unless File.directory?(dir)
      FileUtils.mkdir_p(dir)
    end

    File.open(path, 'w') do |file|
      file.syswrite(picture.read)
    end

    return "/uploads/children/#{child_id}/#{file_name}"

  end

  
end
