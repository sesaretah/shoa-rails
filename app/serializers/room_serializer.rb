class RoomSerializer < ActiveModel::Serializer
  attributes :id, :title, :is_private, :room_id, :pin, :user_uuid, :user_fullname

  def room_id 
    object.uuid.to_i
  end
  def is_private
    object.private ? true : false
  end

  def user_uuid
    if scope && scope[:user_id]
      user = User.find_by_id(scope[:user_id])
      user.uuid if !user.blank?
    end
  end

  def user_fullname
    if scope && scope[:user_id]
      user = User.find_by_id(scope[:user_id])
      user.profile.fullname if !user.blank?
    end
  end

  
end
