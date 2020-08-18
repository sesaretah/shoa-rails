class AbilitySerializer < ActiveModel::Serializer
  attributes :id, :the_ability, :profile_id
  def the_ability
    object.ability
  end

  def profile_id
    object.profile.id if !object.profile.blank?
  end
end
