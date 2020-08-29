class Post < ApplicationRecord
  after_save ThinkingSphinx::RealTime.callback_for(:post)
  has_many :interactions, :as => :interactionable, :dependent => :destroy
  belongs_to :user

  has_many :shares, :dependent => :destroy
  has_many :channels, through: :shares
  has_many :ratings


  def profile
    self.user.profile if self.user
  end

  def share(channel_id)
    Share.create(shareable_type: 'Post', shareable_id: self.id, post_id: self.id , user_id: self.user_id, channel_id: channel_id.to_i)
  end

  def rating(user_id)
    rating = Rating.where(post_id: self.id, user_id: user_id).first 
    return rating.value if rating
  end

  def channel
    Channel.find_by_id(self.channel_id)
  end

  def rated
    ratings = Rating.where(post_id: self.id)
    sum  = 0
    count =  0 
    for rating in  ratings
      sum += rating.value
      count += 1
    end
    if count > 0 
      avg = sum / count 
    else 
      avg = 0
    end
    return avg
  end

  def comments 
    Comment.where(post_id: self.id).order('created_at ASC')
  end




end
