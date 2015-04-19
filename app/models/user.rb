class User < ActiveRecord::Base
  has_many :mentions, class_name: "Mention", foreign_key: "mentioned_user"
  has_many :statuses
  #a fan has idols/celebs and a celeb has fans
  has_many :fan_relationships, class_name: "Relationship", foreign_key: "fan_id"
  has_many :celeb_relationships, class_name: "Relationship", foreign_key: "celebrity_id"

  has_many :followers, through: :celeb_relationships, source: :fan
  has_many :celebs, through: :fan_relationships, source: :celebrity



  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  validates :password, presence: true,  on: :create

  has_secure_password validations: false
end