class Activity < ActiveRecord::Base
  validates :time, presence: true
  validates :action, presence: true
  validates :target_id, presence: true
  validates :description, presence: true
end