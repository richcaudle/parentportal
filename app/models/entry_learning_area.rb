class EntryLearningArea < ActiveRecord::Base
	
  attr_accessible :entry_id, :learning_area_id, :entry, :learning_area

  belongs_to :entry
  belongs_to :learning_area
  
end
