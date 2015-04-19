module ApplicationHelper

  def display_date(dt)
    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end

  def auto_links(status)
    body = mentions_link(status)
    hashtag_link(body)
    return body
  end

  def mentions_link(status)
    if !status.mentions.empty?
      mention_names = []
      status.mentions.each do |mention|
        user = User.find(mention.mentioned_user)
        mention_names << user
      end
      temp = status.body
      mention_names.each do |user| 
        temp.gsub!("@#{user.username}", "#{link_to('@'<<user.username, user_path(user.id))}")
      end
      return temp
    else
      return status.body
    end
  end

  def hashtag_link(body)
    body.gsub!(/#(\S+)/, "<a href='/hashtags/\\1'>#\\1</a>")
  end

end
