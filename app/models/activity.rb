class Activity < ActiveRecord::Base
  validates :object, presence: true  
  validates :action, presence: true  
  validates :description, presence: true

  def get_object
    object.constantize.find_by id: target_id
  end

  def is_not_delete_action?
    self.action != Settings.general.actions.delete
  end
end