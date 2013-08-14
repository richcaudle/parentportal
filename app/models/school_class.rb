class SchoolClass < ActiveRecord::Base
	has_many :children, :dependent => :destroy
    attr_accessible :name, :picture, :school_id

    validates :name, :presence => true
    validates :school_id, :presence => true
    
    def self.my_classes user_id
    	my_roles = UserRole.where("user_id = ? AND class_id > -1", user_id)

		# classes I can access
		class_ids = my_roles.map {|r| r.school_id}

    	SchoolClass.where(:id => class_ids) 
    end

end
