class ProfileSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :surename, :fullname, :bio,  :avatar, :metas, :last_login, :channels, :experties, :followers, :followees, :likes, :bookmarks, :follows

  belongs_to :user

  def channels
    if scope && scope[:user_id] && object.privacy_rule('view_channels', scope[:user_id])
      object.user.channels
    else 
      return []
    end
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
    for meta in Meta.all
      result << {meta: MetaSerializer.new(meta).as_json, actuals: ActiveModel::SerializableResource.new(meta.actuals,  each_serializer: ActualSerializer ).as_json}
    end
    return result
  end

  def followers
    if scope && scope[:user_id] && object.privacy_rule('view_followers', scope[:user_id])
      result = []
      for follower in object.profile_followers
        result << {id: follower.profile.id, user_id: follower.id, fullname: follower.profile.fullname, avatar: follower.profile.profile_avatar}
      end
      return result
    end
  end

  def followees
    if scope && scope[:user_id] && object.privacy_rule('view_followees', scope[:user_id])
      result = []
      for follower in object.profile_followees
        result << {id: follower.profile.id, user_id: follower.id, fullname: follower.profile.fullname, avatar: follower.profile.profile_avatar}
      end
      return result
    end
  end

  def avatar
    object.profile_avatar
  end
end
