class Position < ActiveRecord::Base
  has_many :users, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.models.position.
                                                              max_length_name}
  validates :abbreviation, presence: true, length: {maximum: Settings.models.
                                            position.max_length_abbreviation}
end
