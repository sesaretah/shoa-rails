class ProfileSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :surename, :fullname, :bio,  :avatar, :metas, :last_login, :channels, :experties, :followers, :followees

  belongs_to :user

  def channels
    object.user.channels
  end 
  def last_login
    object.user.last_login
  end

  def bio
    if object.bio.blank? 
      return ""
    else 
      object.bio
    end
  end
  
  def metas
    result = []
    #object.user.actuals.group_by(&:meta_id).each do |meta_id, actuals|
    #  meta = Meta.find(meta_id)
    for meta in Meta.all
      result << {meta: MetaSerializer.new(meta).as_json, actuals: ActiveModel::SerializableResource.new(meta.actuals,  each_serializer: ActualSerializer ).as_json}
    end
    return result
  end

  def followers
    result = []
    for follower in object.profile_followers
      result << {id: follower.profile.id, user_id: follower.id, fullname: follower.profile.fullname, avatar: follower.profile.profile_avatar}
    end
    return result
  end

  def followees
    result = []
    for follower in object.profile_followees
      result << {id: follower.profile.id, user_id: follower.id, fullname: follower.profile.fullname, avatar: follower.profile.profile_avatar}
    end
    return result
  end

  def avatar
    object.profile_avatar
  end
end
