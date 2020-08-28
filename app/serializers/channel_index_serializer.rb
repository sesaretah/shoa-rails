class ChannelIndexSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :content, :likes, :bookmarks, :follows, 
             :liked, :bookmarked, :followed, :avatar
  belongs_to :profile,  serializer: ProfileIndexSerializer


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
