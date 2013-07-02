class School < ActiveRecord::Base
	has_many :school_classes, :dependent => :destroy
	attr_accessible :name, :picture

	validates :name, :presence => true
end
