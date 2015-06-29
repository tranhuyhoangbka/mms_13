class User < ActiveRecord::Base  
  include ActivityLog

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :project_users, dependent: :destroy
  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users
  has_many :projects, through: :project_users
  has_many :position_users, dependent: :destroy
  has_many :positions, through: :position_users
  has_one :leader, foreign_key: "leader_id"  
  belongs_to :team  
  
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
      csv << [name, email, birthday, positions.pluck(:name).join(", ")]
      csv << Settings.csv.skill
      csv << self.skills.pluck(:name)
    end
  end
end
