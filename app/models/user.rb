class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # mount_uploader :profile_photo, ProfilePhotoUploader

  validates :username, presence: true, uniqueness: true

  has_many :builds
  has_many :comments

  def admin?
    admin == true
  end
end
