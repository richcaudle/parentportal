class EntryType < ActiveRecord::Base
  has_many :entries, dependent: :destroy

  attr_accessible :name
end
