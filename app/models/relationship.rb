class Relationship < ActiveRecord::Base

  belongs_to :fan, class_name: 'User', foreign_key: "fan_id"
  belongs_to :celebrity, class_name: 'User', foreign_key: 'celebrity_id'

end
