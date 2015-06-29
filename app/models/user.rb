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
    user_email = nil
    birthday = nil
    skill_ids = Array.new
    name = nil
    CSV.foreach file.path, headers: true, header_converters: :downcase do |row|
      user_email = row["email"] unless row["email"].nil?
      name = row["name"] unless row["name"].nil?
      birthday = row["birthday"] unless row["birthday"].nil?
      skill_ids.push Skill.get_id row["skill"]
    end
    begin
      User.find_by(email: user_email).update_attributes Hash[name: name, email: user_email,
                                                             birthday: birthday,
                                                             skill_ids: skill_ids]
    rescue
      User.create! Hash[name: name, email: user_email, birthday: birthday,
                        password: 123456789,
                        password_confirmation: 123456789,
                        skill_ids: skill_ids]
    end
  end
end
