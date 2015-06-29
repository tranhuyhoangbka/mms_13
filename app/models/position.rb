class Position < ActiveRecord::Base
  include ActivityLog
  extend ExportCsv

  has_many :users, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.models.position.
                                                              max_length_name}
  validates :abbreviation, presence: true, length: {maximum: Settings.models.
                                            position.max_length_abbreviation}

  after_create :log_create
  after_update :log_update
  after_destroy :log_delete

  def self.import_csv file
    CSV.foreach file.path, headers: true, header_converters: :downcase do |row|
      record = Position.find_by(name: row["position"]) || Position.new
      record.attributes = row.to_hash.slice "position", "abbreviation"
      record.save!
    end
  end
end
