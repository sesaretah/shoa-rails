class Profile < ApplicationRecord
  include Rails.application.routes.url_helpers
  after_save ThinkingSphinx::RealTime.callback_for(:profile)
  belongs_to :user
  has_one_attached :avatar
  
  def channels
    self.user.channels if self.user
  end
  def fullname
    "#{self.name} #{self.surename}"
  end

  def add_experties(experties)
    if self.experties.blank?
      self.experties = []
    end
    self.experties << experties
    self.save
  end

  def title
    self.fullname
  end


  def profile_followers
    User.joins(:interactions).where("interactions.interaction_type = 'Follow' AND interactions.interactionable_id = #{self.user_id} AND interactions.interactionable_type = 'Profile'").uniq
  end

  def profile_followees
    User.joins(:interactions).where("interactions.interaction_type = 'Follow' AND interactions.user_id = #{self.user_id} AND interactions.interactionable_type = 'Profile'").uniq
  end

  def profile_avatar
    if self.avatar.attached?
      Rails.application.routes.default_url_options[:host] + rails_blob_url(self.avatar, only_path: true)
    else
      Rails.application.routes.default_url_options[:host] + "/images/default.png"
    end
  end

end
