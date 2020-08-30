class V1::NotificationsController < ApplicationController


  def my
    notifications = Notification.where(source_user_id: current_user.id).order('created_at DESC')
    notifications = Notification.trim_blanks(notifications)
    if !notifications.blank? 
      render json: { data: ActiveModel::SerializableResource.new(notifications,  each_serializer: NotificationSerializer ).as_json, klass: 'Notification' }, status: :ok   
    end
  end

  def seen
    notifications = Notification.where(source_user_id: current_user.id)
    Notification.seen_list(notifications)
    render json: { data: ActiveModel::SerializableResource.new(notifications,  each_serializer: NotificationSerializer ).as_json, klass: 'Notification' }, status: :ok   
  end


end
