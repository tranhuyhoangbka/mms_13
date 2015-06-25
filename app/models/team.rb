class Team < ActiveRecord::Base
  include ActivityLog

  has_many :users
  has_many :projects, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true

  after_create :log_create
  after_update :log_update
  after_destroy :log_delete
end
