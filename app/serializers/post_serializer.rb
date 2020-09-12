class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :draft, :content, :likes, :bookmarks, 
              :follows, :liked, :bookmarked, :followed, :comments, 
              :rating, :rated, :editable, :deletable
  belongs_to :profile,  serializer: ProfileIndexSerializer
  #belongs_to :comments,  serializer: CommentSerializer


  def editable
    if scope && scope[:user_id] && object.user_id == scope[:user_id]
      return true
    else
      return false
    end
  end

  def deletable
    flag = false
    if scope && scope[:user_id]
      flag = true if object.user_id == scope[:user_id]
      user = User.find(scope[:user_id])
      flag = true if !user.blank? && !user.ability.blank? && user.has_ability('delete_post')
    end
    return flag
  end

  def comments
    comments = object.comments.order('created_at ‌ASC')#.limit(instance_options[:page].to_i*5)
    return ActiveModel::SerializableResource.new(comments,  each_serializer: CommentSerializer, scope: {user_id: scope[:user_id]} ).as_json
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

  def rating
    object.rating(instance_options[:user_id])
  end

  def rated
    object.rated
  end
end
