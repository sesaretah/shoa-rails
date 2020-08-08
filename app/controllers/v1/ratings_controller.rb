class V1::RatingsController < ApplicationController


  def create
    rating = Rating.where(post_id: params[:post_id], user_id: current_user.id).first
    if rating.blank?
      rating = Rating.new(rating_params)
      rating.user_id = current_user.id
    else
      rating.value = params[:value]
    end
    post = rating.post
    if rating.save
      render json: { data:  PostSerializer.new(post, user_id: current_user.id, page: 1).as_json, klass: 'Post'}, status: :ok
    end
  end


  def destroy
    @rating = Rating.find(params[:id])
    if @rating.destroy
      render json: { data: 'OK'}, status: :ok
    end
  end

  def rating_params
    params.require(:rating).permit!
  end
end
