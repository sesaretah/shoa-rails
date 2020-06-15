class FriendshipSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :fullname, :avatar,:followers, :followees

  def followers
    result = []
    for follower in object.all_profile_followers
      result << {id: follower.profile.id, user_id: follower.id, fullname: follower.profile.fullname, avatar: follower.profile.profile_avatar}
    end
    return result
  end

  def followees
    result = []
    for follower in object.all_profile_followees
      result << {id: follower.profile.id, user_id: follower.id, fullname: follower.profile.fullname, avatar: follower.profile.profile_avatar}
    end
    return result
  end

  def avatar
    object.profile_avatar
  end
end
