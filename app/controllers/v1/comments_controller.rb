class V1::CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    params[:page].blank? ? @page = 1 : @page = params[:page]
    @post = @comment.post
    if @comment.save
      render json: { data:  PostSerializer.new(@post, user_id: current_user.id, scope: {user_id: current_user.id}, page: @page).as_json, klass: 'Post'}, status: :ok
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    params[:page].blank? ? @page = 1 : @page = params[:page]
    if @comment.destroy
      render json: { data:  PostSerializer.new(@post, user_id: current_user.id, scope: {user_id: current_user.id}, page: @page).as_json, klass: 'Post'}, status: :ok
    end
  end

  def comment_params
    params.require(:comment).permit!
  end
end
