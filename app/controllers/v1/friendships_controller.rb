class V1::FriendshipsController < ApplicationController

  def show
    @profile = Profile.find(params[:id])
    render json: { data: FriendshipSerializer.new(@profile).as_json, klass: 'Friendship' }, status: :ok
  end
  
end
