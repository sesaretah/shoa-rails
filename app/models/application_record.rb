class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def likes
    self.interactions.where(interaction_type: 'Like').count if self.interactions
  end

  def bookmarks
    self.interactions.where(interaction_type: 'Bookmark').count if self.interactions
  end

  def follows
    self.interactions.where(interaction_type: 'Follow').count if self.interactions
  end

  def followers
    User.joins(:interactions).where('interactions.interaction_type = ?', 'Follow')
  end

  def followees
    User.joins(:interactions).where('interactions.interaction_type = ?', 'Follow')
  end


  def liked(user_id)
    if self.interactions.where(interaction_type: 'Like', user_id: user_id).first
      return true
    else
      return false
    end
  end

  def bookmarked(user)
    if self.interactions.where(interaction_type: 'Bookmark', user_id: user_id).first
      return true
    else
      return false
    end
  end

  def followed(user)
    if self.interactions.where(interaction_type: 'Follow', user_id: user_id).first
      return true
    else
      return false
    end
  end
end
