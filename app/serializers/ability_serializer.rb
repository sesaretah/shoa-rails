class AbilitySerializer < ActiveModel::Serializer
  attributes :id, :the_ability, :profile_id, :the_roles
  def the_ability
    object.ability
  end

  def the_roles
    object.roles
  end

  def profile_id
    object.profile.id if !object.profile.blank?
  end
end
