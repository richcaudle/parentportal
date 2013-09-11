class LearningArea < ActiveRecord::Base
	has_many :entry_learning_areas
	has_many :entries, through: :entry_learning_areas
	attr_accessible :name
end
