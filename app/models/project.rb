class Project < ActiveRecord::Base
  include ActivityLog

  belongs_to :team
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users

  validates :name, presence: true
  validates :abbreviation, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  after_create :log_create
  after_update :log_update
  after_destroy :log_delete
end
