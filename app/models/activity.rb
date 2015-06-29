class Activity < ActiveRecord::Base
  validates :object, presence: true  
  validates :action, presence: true  
  validates :description, presence: true
  
  scope :old_activities, ->{where "created_at < ?",
                                  Time.zone.now - Settings.general.days_of_week} 

  def get_object
    object.constantize.find_by id: target_id
  end

  def is_not_delete_action?
    self.action != Settings.general.actions.delete
  end
end