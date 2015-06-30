class User < ActiveRecord::Base  
  include ActivityLog

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :project_users, dependent: :destroy
  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users
  has_many :projects, through: :project_users  
  belongs_to :position
  belongs_to :team
  has_one :leader, foreign_key: "leader_id"
  
  accepts_nested_attributes_for :skill_users, allow_destroy: true

  validates :name, presence: true
  validates :birthday, presence: true

  mount_uploader :avatar, ImageUploader
  
  after_create :log_create
  after_update :log_update
  after_destroy :log_delete

  scope :no_team_users, ->{where team_id: nil}
  scope :normal, ->{where role: Settings.models.user.roles.user}

  Settings.models.user.roles.each do |role_key, role_value|
    define_method("is_#{role_key}?") {role == role_value}
  end

  def to_csv
    CSV.generate do |csv|
      csv << Settings.csv.user_column
      csv << [name, email, birthday, position.name]
      csv << Settings.csv.skill
      csv << self.skills.pluck(:name)
    end
  end

  def self.import_csv file
    attributes_hash = Hash.new{|hash, key| hash[key] = []}
    CSV.foreach file.path, headers: true, header_converters: :downcase do |row|
      t = row.to_hash.slice "name", "email", "birthday", "skill"
      t.keys.each {|key| attributes_hash[key].push t[key] unless t[key].nil?}
    end
    attributes = Hash[name: attributes_hash["name"].first, 
                      email: attributes_hash["email"].first,
                      birthday: attributes_hash["birthday"].first,
                      skill_ids: attributes_hash["skill"].map{|s| Skill.get_id s}]
    begin
      User.find_by(email: attributes[:email]).update_attributes attributes
    rescue
      attributes.merge! Hash[password: 123456789, password_confirmation: 123456789]
      User.create! attributes
    end
  end
end
