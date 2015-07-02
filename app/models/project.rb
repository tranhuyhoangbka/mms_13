class Project < ActiveRecord::Base
  include ActivityLog

  belongs_to :team
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  accepts_nested_attributes_for :project_users, allow_destroy: true
  belongs_to :leader, class_name: "User"
  
  validates :name, presence: true
  validates :abbreviation, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  after_create :log_create
  after_update :log_update
  after_destroy :log_delete
  after_save :assign_user_project

  def to_csv
    CSV.generate do |csv|
      csv << Settings.csv.project_column
      csv << [name, abbreviation, start_date, end_date, team.name, leader.name]
      csv << Settings.csv.member
      csv << users.pluck(:name)
    end
  end

  def self.import_csv file
    attributes_hash = Hash.new{|hash, key| hash[key] = []}
    CSV.foreach file.path, headers: true, header_converters: :downcase do |row|
      t = row.to_hash.slice "name", "abbreviation", "start", "end", "member"
      t.keys.each {|key| attributes_hash[key].push t[key] unless t[key].nil?}
    end
    attributes = Hash[name: attributes_hash["name"].first, 
                      abbreviation: attributes_hash["abbreviation"].first,
                      start_date: attributes_hash["start"].first,
                      end_date: attributes_hash["end"].first,
                      user_ids: attributes_hash["member"].map{|m| User.get_id m}]
    begin
      Project.find_by(name: attributes[:name]).update_attributes attributes
    rescue
      Project.create! attributes
    end
  end

  private
  def assign_user_project
    unless users == team.users
      project_users.destroy_all
      users << team.users
    end
  end
end
