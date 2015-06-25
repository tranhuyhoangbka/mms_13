class ChangeLevelFromSkillUsers < ActiveRecord::Migration
  def change
    change_column :skill_users, :level, :string
  end
end
