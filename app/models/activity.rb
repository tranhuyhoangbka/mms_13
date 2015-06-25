class Activity < ActiveRecord::Base
  validates :object, presence: true  
  validates :action, presence: true  
  validates :description, presence: true
end