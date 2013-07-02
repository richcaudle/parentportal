class SchoolClass < ActiveRecord::Base
	has_many :children, :dependent => :destroy
    attr_accessible :name, :picture, :school_id

    validates :name, :presence => true
    validates :school_id, :presence => true
    
end
