class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    after_create :create_notification

    def profile
        self.user.profile if self.user && self.user.profile
    end

    def owner
        self.post.user if self.post.user
    end

    def title

    end

    def reply
        Comment.find_by_id(self.reply_id)
    end

    #def notify_by_mail
   #     Notification.create(notifiable_id: self.post.id, notifiable_type: 'Post', notification_type: 'Comment', source_user_id: self.user_id, target_user_ids: self.notifiable_followers , seen: false)
   # end

    def create_notification
        Notification.create(
          notifiable_id: self.post.id, notifiable_type: 'Post', 
          notification_type: 'Comment', source_user_id: self.user_id, target_user_hash: {},
          target_user_ids: self.notifiable_followers , seen: false, custom_text: self.content)
    end

    def notifiable_followers
        user_ids = [self.owner.id]
        user_ids = user_ids + self.post.followers.pluck(:id) if !self.post.blank? && !self.post.followers.blank?
        return user_ids
    end
end
