class Position < ActiveRecord::Base
  include ActivityLog

  has_many :users, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.models.position.
                                                              max_length_name}
  validates :abbreviation, presence: true, length: {maximum: Settings.models.
                                            position.max_length_abbreviation}

  after_create :log_create
  after_update :log_update
  after_destroy :log_delete
end
