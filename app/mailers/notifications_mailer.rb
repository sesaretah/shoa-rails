class NotificationsMailer < ActionMailer::Base

    def notify_email(user_id, notify_type, notifier, notify_text)
        @user = User.find(user_id)
        case notify_type
        when  'Like'
            @body = "#{t(:like_notification)} #{t(:via)} #{notifier} #{t(:onto)} #{notify_text}"
        when  'Bookmark'
            @body = "#{t(:bookmark_notification)}  #{t(:via)} #{notifier} #{t(:onto)} #{notify_text}" 
        when  'Follow'
            @body = "#{notify_text}  #{t(:via)} #{notifier} #{t(:follow_notification)}" 
        when  'Share'
            @body = "#{t(:share_notification)}  #{t(:via)} #{notifier} #{t(:onto)} #{notify_text}" 
        when  'Comment'
            @body = "#{t(:comment_notification)}  #{t(:via)} #{notifier} #{t(:onto)} #{notify_text}" 
        end
        mail(   :to      => @user.email,
                :from => 'snadmin@ut.ac.ir',
                :subject => t(:notification)
        ) do |format|
          format.text
          format.html
        end
    end
end