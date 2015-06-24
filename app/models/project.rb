class Project < ActiveRecord::Base
  include ActivityLog

  belongs_to :team
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  accepts_nested_attributes_for :project_users, allow_destroy: true
  belongs_to :leader, class_name: "User"
  
  validates :name, presence: true
  validates :abbreviation, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  after_create :log_create
  after_update :log_update
  after_destroy :log_delete
end
