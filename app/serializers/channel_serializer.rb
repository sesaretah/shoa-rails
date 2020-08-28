class ChannelSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :content, :likes, :bookmarks, :follows, 
             :liked, :bookmarked, :followed, :posts, :avatar, :editable
  belongs_to :profile,  serializer: ProfileIndexSerializer
  #has_many :posts,  serializer: PostSerializer
  def editable
    if scope && scope[:user_id] && object.user_id == scope[:user_id]
      return true
    else
      return false
    end
  end

  def posts
    result = []
    for post in object.posts
      result << PostSerializer.new(post, scope: {user_id: scope[:user_id]}).as_json
    end
    return result
  end

  def admins
    
  end

  def avatar
    Rails.application.routes.default_url_options[:host] + "/images/megaphone.png"
  end

  def content
    object.send(:content).to_s
  end

  def liked
    object.liked(instance_options[:user_id])
  end

  def bookmarked
    object.bookmarked(instance_options[:user_id])
  end

  def followed
    object.followed(instance_options[:user_id])
  end
end
