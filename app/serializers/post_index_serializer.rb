class PostIndexSerializer < ActiveModel::Serializer
  #include Rails.application.routes.url_helpers
  attributes :id, :title, :draft, :content, :likes, :bookmarks, :follows, 
  :liked, :bookmarked, :followed, :comments_count, :ratings_count
  belongs_to :profile,  serializer: ProfileIndexSerializer
  #belongs_to :comments,  serializer: CommentSerializer


  def liked
    object.liked(instance_options[:user_id])
  end

  def bookmarked
    object.bookmarked(instance_options[:user_id])
  end

  def followed
    object.followed(instance_options[:user_id])
  end

  def comments_count
    if object.comments.blank? || object.comments.count.blank?
      return 0
    else
      return object.comments.count 
    end
  end

  def ratings_count
    if object.ratings.blank? || object.ratings.count.blank?
      return 0
    else
      return object.ratings.count 
    end
  end


end
