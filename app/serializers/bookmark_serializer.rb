class BookmarkSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :title, :id, :model

  def id 
    object.interactionable.id
  end

  def title 
    object.interactionable.title
  end

  def model 
    object.interactionable.class.name.downcase.pluralize
  end

end
