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
  
  accepts_nested_attributes_for :skill_users, allow_destroy: true

  validates :name, presence: true
  validates :birthday, presence: true

  mount_uploader :avatar, ImageUploader
  
  after_create :log_create
  after_update :log_update
  after_destroy :log_delete

  scope :no_team_users, ->{where team_id: nil}
  scope :normal, ->{where role: Settings.models.user.roles.admin}

  Settings.models.user.roles.each do |role_key, role_value|
    define_method("is_#{role_key}?") {role == role_value}
  end
end
