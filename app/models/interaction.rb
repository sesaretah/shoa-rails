class Interaction < ApplicationRecord
  belongs_to :interactionable, :polymorphic => true
  after_create :notify_by_mail
  belongs_to :user

  def count
    Interaction.where(interaction_type: self.interaction_type, interactionable_id: self.interactionable_id, interactionable_type: self.interactionable_type).count
  end

  def notify_by_mail
    Notification.create(notifiable_id: self.interactionable_id, notifiable_type: self.interactionable_type, notification_type: self.interaction_type, source_user_id: self.user_id, target_user_ids: [self.owner.id] , seen: false)
    #NotificationsMailer.notify_email(self.owner.id, self.interaction_type, self.user.profile.fullname, self.interactionable.title ).deliver_later
  end

  def owner
    @interactionable = self.interactionable_type.classify.constantize.find_by_id(self.interactionable_id)
    return @interactionable.user if @interactionable
  end

end
