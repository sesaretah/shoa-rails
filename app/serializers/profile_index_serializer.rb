class ProfileIndexSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :surename, :fullname, :avatar

  belongs_to :user




  def avatar
    object.profile_avatar
  end
end
