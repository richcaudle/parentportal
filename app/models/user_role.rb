class UserRole < ActiveRecord::Base
	has_many :schools
	has_many :children
	has_many :school_classes
	has_many :users
	has_many :roles
	attr_accessible :class_id, :role_id, :school_id, :child_id, :user_id
end
