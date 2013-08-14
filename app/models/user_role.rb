class UserRole < ActiveRecord::Base
	has_many :schools
	has_many :children
	has_many :school_classes
	has_many :users
	has_many :roles
	attr_accessible :class_id, :role_id, :school_id, :child_id, :user_id

	def self.is_superuser user_id
	    UserRole.find_by_user_id_and_role_id(user_id, 1)
	end

end
