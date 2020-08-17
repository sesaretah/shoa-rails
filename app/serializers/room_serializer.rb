class RoomSerializer < ActiveModel::Serializer
  attributes :id, :title, :is_private, :room_id

  def room_id 
    object.uuid.to_i
  end
  def is_private
    object.private ? true : false
  end
end
