class Profile < ApplicationRecord
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
end
