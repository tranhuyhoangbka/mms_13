class Team < ActiveRecord::Base
  has_many :users
  has_many :projects, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
