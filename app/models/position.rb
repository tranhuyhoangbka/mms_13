class Position < ActiveRecord::Base
  has_many :users, dependent: :destroy

  validates :name, presence: true, length: {maximum: 150}
  validates :abbreviation, presence: true, length: {maximum: 50}
end
