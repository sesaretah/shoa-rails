class InteractionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :data, :klass

  def data
    case instance_options[:source_type]
    when nil
      PostSerializer.new(object.interactionable, user_id: instance_options[:user_id],  scope: {user_id: scope[:user_id]}).as_json
    when "Channel"
      channel = Channel.find_by_id(instance_options[:source_id])
      ChannelSerializer.new(channel, user_id: instance_options[:user_id], scope: {user_id: scope[:user_id]}).as_json if channel
    end
  end

  def klass
    if instance_options[:source_type].blank?
      "Post"
    else
      "Channel"
    end
  end
end
