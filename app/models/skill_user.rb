class SkillUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill

  validates :level, presence: true, inclusion: {in: 1..10}
  validates :experience_year, presence: true
end
