class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :content, :profile, :target_type, :target_id, :seen

  def content
    case object.notification_type
    when  'Like'
      return "#{I18n.t(:like_notification)}"
    when  'Bookmark'
      return "#{I18n.t(:bookmark_notification)}" 
    when  'Follow'
      return "#{I18n.t(:follow_notification)}" 
    when  'Share'
      return "#{I18n.t(:share_notification)}" 
    end
  end

  def profile
    ProfileSerializer.new(object.user.profile).as_json
  end

  def target_type
    object.notifiable_type.tableize 
  end

  def target_id
    object.notifiable_id
  end
end
