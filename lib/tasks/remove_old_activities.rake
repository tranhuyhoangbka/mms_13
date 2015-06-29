desc "remove old activities"
task remove_old_activities: :environment do
  Activity.old_activities.destroy_all
end