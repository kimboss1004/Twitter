class AddRetweetStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :retweet_id, :integer
  end
end
