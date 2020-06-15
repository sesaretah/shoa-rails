class Profile < ApplicationRecord
  include Rails.application.routes.url_helpers
  after_save ThinkingSphinx::RealTime.callback_for(:profile)
  has_many :interactions, :as => :interactionable, :dependent => :destroy
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
    user_ids = Interaction.where("interactions.interaction_type = 'Follow' AND interactions.user_id = #{self.user_id} AND interactions.interactionable_type = 'Profile'").pluck(:interactionable_id).uniq
    return User.where('id IN (?)', user_ids)
  end

  def profile_avatar
    if self.avatar.attached?
      Rails.application.routes.default_url_options[:host] + rails_blob_url(self.avatar, only_path: true)
    else
      Rails.application.routes.default_url_options[:host] + "/images/default.png"
    end
  end

  def privacy_rule(rule, user_id)
    @flag =  true 
    if !self.privacy.blank?
      for setting in self.privacy
        if setting['title'] == rule
          value =  setting['value']
        end
      end
    end

    case value
      when 'all'
        @flag =  true
      when 'none'
        @flag =  false
      when 'followers'
        @user = User.find_by_id(user_id)
        if !@user.blank?
          if @user.follow(self.user)
            @flag =  true
          end
        end
    end
    @flag =  true if self.user_id == user_id
    return @flag
  end

end
