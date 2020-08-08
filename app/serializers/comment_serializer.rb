class CommentSerializer < ActiveModel::Serializer
  include ActionView::Helpers::TextHelper
  attributes :id, :content, :created_at, :profile, :reply_to
  def profile 
     ProfileSerializer.new(object.profile).as_json
  end 

  def reply_to
    truncate(object.reply.content) if object.reply
  end
end
