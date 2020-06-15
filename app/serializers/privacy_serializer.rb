class PrivacySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :fullname, :avatar, :privacy_settings, :setting_schemas

  def privacy_settings
    if object.privacy.blank?
      return []
    else 
      return object.privacy
    end
  end

  def setting_schemas
    @setting = Setting.where(title: 'privacy').first
    return JSON.parse(@setting.content) if @setting
  end

  def avatar
    object.profile_avatar
  end
end
