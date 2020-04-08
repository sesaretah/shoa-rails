class Share < ApplicationRecord
  belongs_to :post
  belongs_to :channel
  belongs_to :user
  after_create :notify_by_mail

  def owner
    self.post.user
  end 

  def notify_by_mail
    Notification.create(notifiable_id: self.post.id, notifiable_type: 'Post', notification_type: 'Share', source_user_id: self.user_id, target_user_ids: [self.owner.id] , seen: false)
  end
end
