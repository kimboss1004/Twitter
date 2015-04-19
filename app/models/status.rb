class Status < ActiveRecord::Base
  has_many :mentions
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :parent_status, foreign_key: 'retweet_id', class_name: 'Status' 


  validates :creator, presence: true
  validates :body, presence: true

  after_save :add_mentions!


  def add_mentions!
    body = self.body
    mentions = body.scan(/@(\w*)/)
    
    if !mentions.empty?
      mentions.each do |mention|
        m = mention.first
        user = User.find_by(username: m)

        if user
          Mention.create(mentioned_user: user.id, status_id: self.id)
        end
      end 
    end
  end

end