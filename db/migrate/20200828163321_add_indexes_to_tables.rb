class AddIndexesToTables < ActiveRecord::Migration[5.2]
  def change
    add_index :profiles, :user_id
    add_index :posts, :user_id
    add_index :channels, :user_id
    add_index :interactions, :user_id
    add_index :roles, :user_id
    add_index :ratings, :user_id
    add_index :comments, :user_id
    add_index :devices, :user_id
    add_index :notification_settings, :user_id
    add_index :shares, :user_id
    
    add_index :interactions, :interaction_type
    add_index :interactions, :interactionable_id
    add_index :interactions, :interactionable_type

    add_index :comments, :post_id
    add_index :shares, :post_id
    add_index :shares, :channel_id

    add_index :actuals, :meta_id

    add_index :notifications, :notifiable_id
    add_index :notifications, :notifiable_type

  end
end
