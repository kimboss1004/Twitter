class Mention < ActiveRecord::Base
  belongs_to :user, class_name: "User", foreign_key: "mentioned_user"
  belongs_to :status

end