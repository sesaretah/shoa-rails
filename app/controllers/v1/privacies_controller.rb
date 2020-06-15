class V1::PrivaciesController < ApplicationController

  def show
    @profile = current_user.profile
    render json: { data: PrivacySerializer.new(@profile).as_json, klass: 'Privacy' }, status: :ok
  end

  def update
    @profile = current_user.profile
    @profile.privacy = params[:privacy]
    @profile.save
    render json: { data: PrivacySerializer.new(@profile).as_json, klass: 'Friendship' }, status: :ok
  end


  def privacy_params
    params.require(:profile).permit!
  end
  
end
