class V1::NotificationSettingsController < ApplicationController

  def index
    notification_settings = current_user.notification_settings.order('created_at DESC')
    render json: { data: ActiveModel::SerializableResource.new(notification_settings, user_id: current_user.id,  each_serializer: NotificationSettingSerializer ).as_json, klass: 'NotificationSetting' }, status: :ok
  end


  def show
    @notification_setting = current_user.notification_setting
    if !@notification_setting.blank?
      render json: { data:  NotificationSettingSerializer.new(@notification_setting, user_id: current_user.id).as_json, klass: 'NotificationSetting'}, status: :ok
    else 
      render json: { data: [], klass: 'NotificationSetting'}, status: :ok
    end
  end

  def add
    @notification_setting = current_user.notification_setting
    @notification_setting = NotificationSetting.new(user_id: current_user.id) if @notification_setting.blank?
    @notification_setting.add_notification_setting(params[:item])
    if @notification_setting.save
      render json: { data: NotificationSettingSerializer.new(@notification_setting).as_json, klass: 'NotificationSetting' }, status: :ok
    end
  end


  
  
  def remove
    @notification_setting = current_user.notification_setting
    @notification_setting = NotificationSetting.new(user_id: current_user.id) if @notification_setting.blank?
    @notification_setting.remove_notification_setting(params[:item])
    if @notification_setting.save
      render json: { data: NotificationSettingSerializer.new(@notification_setting).as_json, klass: 'NotificationSetting' }, status: :ok
    end
  end


  def create
    @notification_setting = NotificationSetting.new(notification_setting_params)
    @notification_setting.user_id = current_user.id
    if @notification_setting.save
      render json: { data: NotificationSettingSerializer.new(@notification_setting).as_json, klass: 'NotificationSetting' }, status: :ok
    end
  end

  def update
    @notification_setting = NotificationSetting.find(params[:id])
    if @notification_setting.update_attributes(notification_setting_params)
      render json: { data: NotificationSettingSerializer.new(@notification_setting, user_id: current_user.id).as_json, klass: 'NotificationSetting' }, status: :ok
    else
      render json: { data: @notification_setting.errors.full_messages  }, status: :ok
    end
  end

  def destroy
    @notification_setting = NotificationSetting.find(params[:id])
    if @notification_setting.destroy
      render json: { data: 'OK'}, status: :ok
    end
  end

  def notification_setting_params
    params.all.permit#require(:notification_setting).permit!
  end
end
