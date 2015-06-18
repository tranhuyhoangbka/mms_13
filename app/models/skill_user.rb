class SkillUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill

  validates :level, presence: true, inclusion: {in: Settings.models.skill_user.
                                                             level_inclusion}
  validates :experience_year, presence: true
end
