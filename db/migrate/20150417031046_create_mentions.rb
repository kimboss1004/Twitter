class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.integer :mentioned_user, :status_id
    end
  end
end
