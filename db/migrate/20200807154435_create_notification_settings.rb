class CreateNotificationSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_settings do |t|
      t.integer :user_id
      t.json :notification_setting

      t.timestamps
    end
  end
end
