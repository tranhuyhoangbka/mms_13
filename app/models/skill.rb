class Skill < ActiveRecord::Base
  include ActivityLog
  extend ExportCsv

  has_many :skill_users, dependent: :destroy
  has_many :users, through: :skill_users

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  after_create :log_create
  after_update :log_update
  after_destroy :log_delete

  def self.get_id skill_name
    Skill.find_by(name: skill_name).id
  end

  def self.import_csv file
    CSV.foreach file.path, headers: true, header_converters: :downcase do |row|
      record = Skill.find_by(name: row["skill"]) || Skill.new
      record.attributes = row.to_hash.slice "skill"
      record.save!
    end
  end
end
