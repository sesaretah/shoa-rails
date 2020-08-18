class V1::ChannelsController < ApplicationController

  def index
    channels = Channel.paginate(page: params[:page], per_page: 6)
    render json: { data: ActiveModel::SerializableResource.new(channels, user_id: current_user.id,  each_serializer: ChannelSerializer ).as_json, klass: 'Channel' }, status: :ok
  end

  def my
    channels = Channel.where(user_id: current_user.id)
    render json: { data: ActiveModel::SerializableResource.new(channels, user_id: current_user.id,  each_serializer: ChannelSerializer ).as_json, klass: 'Channel' }, status: :ok
  end

  def search
    if !params[:q].blank?
      channels = Channel.search params[:q], star: true, page: params[:page], per_page: 6
    else 
      channels = Channel.paginate(page: params[:page], per_page: 6)
    end
    render json: { data: ActiveModel::SerializableResource.new(channels,  each_serializer: ChannelSerializer ).as_json, klass: 'Channel' }, status: :ok
  end


  def show
    @channel = Channel.find(params[:id])
    render json: { data:  ChannelSerializer.new(@channel, user_id: current_user.id, scope: {user_id: current_user.id}).as_json, klass: 'Channel'}, status: :ok
  end

  def create
    @channel = Channel.new(channel_params)
    @channel.user_id = current_user.id
    if @channel.save
      render json: { data: ChannelSerializer.new(@channel).as_json, klass: 'Channel' }, status: :ok
    end
  end

  def update
    @channel = Channel.find(params[:id])
    if owner(@channel, current_user) && @channel.update_attributes(channel_params)
      render json: { data: ChannelSerializer.new(@channel, user_id: current_user.id).as_json, klass: 'Channel' }, status: :ok
    else
      render json: { data: @channel.errors.full_messages  }, status: :ok
    end
  end

  def destroy
    @channel = Channel.find(params[:id])
    if owner(@channel, current_user) && @channel.destroy
      render json: { data: 'OK'}, status: :ok
    end
  end

  def channel_params
    params.require(:channel).permit!
  end
end
