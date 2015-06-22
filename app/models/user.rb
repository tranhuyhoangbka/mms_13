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
  
  Settings.models.user.roles.each do |role_user|
    define_method("is_#{role_user}?") {role == role_user}
  end
end
