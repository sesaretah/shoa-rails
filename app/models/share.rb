class Share < ApplicationRecord
  belongs_to :post
  belongs_to :channel
  belongs_to :user
  after_create :create_notification

  def owner
    self.post.user
  end 

  #def notify_by_mail
  #  Notification.create(notifiable_id: self.post.id, notifiable_type: 'Post', notification_type: 'Share', source_user_id: self.user_id, target_user_ids: [self.owner.id] , seen: false)
  #end

  def create_notification
    if !self.channel.blank? && !self.notifiable_followers.blank?
      Notification.create(
        notifiable_id: self.channel.id, notifiable_type: 'Channel', 
        notification_type: 'Post', source_user_id: self.user_id, target_user_hash: {},
        target_user_ids: self.notifiable_followers , seen: false, custom_text: self.post.title)
    end
  end

  def notifiable_followers
    user_ids = []
    user_ids =  self.channel.followers.pluck(:id) if !self.channel.blank? && !self.channel.followers.blank?
    return user_ids
  end
end
