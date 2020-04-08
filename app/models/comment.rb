class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    after_create :notify_by_mail

    def profile
        self.user.profile if self.user && self.user.profile
    end

    def owner
        self.post.user if self.post.user
    end

    def title

    end

    def notify_by_mail
        Notification.create(notifiable_id: self.post.id, notifiable_type: 'Post', notification_type: 'Comment', source_user_id: self.user_id, target_user_ids: [self.owner.id] , seen: false)
    end
end
