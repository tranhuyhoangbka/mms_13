module ActivityLog

  private
  def create_activity_log class_name, action_name, target_id
    Activity.create!(
      object: class_name,
      action: action_name,
      target_id: target_id,
      description: "#{action_name} #{class_name}")
  end  

  Settings.general.actions.each do |action_key, action_value|
    define_method("log_#{action_key}"){create_activity_log self.class.name,
                                                           action_value, self.id}
  end
end