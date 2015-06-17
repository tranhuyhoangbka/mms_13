class Project < ActiveRecord::Base
  belongs_to :team
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users

  validates :name, presence: true
  validates :abbreviation, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
