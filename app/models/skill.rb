class Skill < ActiveRecord::Base
  include ActivityLog
  extend ExportCsv

  has_many :skill_users, dependent: :destroy
  has_many :users, through: :skill_users

  validates :name, presence: true

  after_create :log_create
  after_update :log_update
  after_destroy :log_delete
end
