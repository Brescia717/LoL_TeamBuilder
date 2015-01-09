class User < ActiveRecord::Base
  acts_as_votable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # mount_uploader :profile_photo, ProfilePhotoUploader

  validates :username, presence: true, uniqueness: true
  validates :summoner_name, presence: true, uniqueness: true
  validates :primary_role, presence: true
  validates :secondary_role, presence: true

  has_many :teams
  has_many :comments
  has_many :votes
  has_many :bios
  has_one  :stat

  def admin?
    admin == true
  end
end
