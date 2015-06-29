class Position < ActiveRecord::Base
  include ActivityLog
  extend ExportCsv
  
  has_many :position_users, dependent: :destroy
  has_many :users, through: :position_users

  validates :name, presence: true, length: {maximum: Settings.models.position.
                                                              max_length_name}
  validates :abbreviation, presence: true, length: {maximum: Settings.models.
                                            position.max_length_abbreviation}

  after_create :log_create
  after_update :log_update
  after_destroy :log_delete
end
