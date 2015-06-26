class Team < ActiveRecord::Base
  include ActivityLog

  has_many :users
  has_many :projects, dependent: :destroy
  belongs_to :leader, class_name: "User"

  validates :name, presence: true
  validates :description, presence: true

  after_create :log_create
  after_update :log_update
  after_destroy :log_delete

  def to_csv
    CSV.generate do |csv|
      csv << Settings.csv.team_column
      csv << [name, description, leader.name]
      csv << Settings.csv.member
      csv << users.pluck(:name)
    end
  end
end
