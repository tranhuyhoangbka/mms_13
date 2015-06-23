class User < ActiveRecord::Base  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :project_users, dependent: :destroy
  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users
  has_many :projects, through: :project_users
  belongs_to :position
  belongs_to :team

  validates :name, presence: true
  validates :birthday, presence: true

  mount_uploader :avatar, ImageUploader
  
  scope :no_team_users, ->{where team_id: nil}
  scope :normal, ->{where role: Settings.models.user.roles[1]}

  Settings.models.user.roles.each do |role_user|
    define_method("is_#{role_user}?") {role == role_user}
  end
end
