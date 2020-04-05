class Profile < ApplicationRecord
  #after_save ThinkingSphinx::RealTime.callback_for(:profile)
  belongs_to :user
  has_one_attached :avatar
  
  def channels
    self.user.channels if self.user
  end
  def fullname
    "#{self.name} #{self.surename}"
  end


end
