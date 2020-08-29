class V1::BookmarksController < ApplicationController


  def my
    bookmarks = Interaction.where(interaction_type: "Bookmark", user_id: current_user.id).order('created_at DESC')
    if !bookmarks.blank?
      render json: { data: ActiveModel::SerializableResource.new(bookmarks,  each_serializer: BookmarkSerializer, scope: {user_id: current_user.id}) , klass: 'Bookmark'}, status: :ok   
    end
  end


end
