class V1::PostsController < ApplicationController

  def index
    #@friend_ids = Friendship.friend_ids(current_user)
    #posts = Post.where('user_id IN (?)', @friend_ids).order('created_at desc')
    posts = Post.all.order('updated_at DESC').paginate(page: params[:page], per_page: 15)
    render json: { data: ActiveModel::SerializableResource.new(posts, user_id: current_user.id,  each_serializer: PostSerializer, scope: {user_id: current_user.id} ).as_json, klass: 'Post' }, status: :ok
  end

  def search
    if !params[:q].blank?
      posts = Post.search params[:q], star: true, page: params[:page], per_page: 15
    else 
      posts = Post.paginate(page: params[:page], per_page: 15)
    end
    render json: { data: ActiveModel::SerializableResource.new(posts,  each_serializer: PostSerializer, scope: {user_id: current_user.id} ).as_json, klass: 'Post' }, status: :ok
  end


  def show
    @post = Post.find(params[:id])
    params[:page].blank? ? @page = 1 : @page = params[:page]
    render json: { data:  PostSerializer.new(@post, user_id: current_user.id, page: @page, scope: {user_id: current_user.id}).as_json, klass: 'Post'}, status: :ok
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      @post.share(params[:channel_id]) if !params[:channel_id].blank?
      render json: { data: PostSerializer.new(@post, scope: {user_id: current_user.id}).as_json, klass: 'Post' }, status: :ok
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      render json: { data: PostSerializer.new(@post, scope: {user_id: current_user.id}, user_id: current_user.id).as_json, klass: 'Post' }, status: :ok
    else
      render json: { data: @post.errors.full_messages  }, status: :ok
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      render json: { data: 'OK', klass: 'PostDelete'}, status: :ok
    end
  end

  def post_params
    params.require(:post).permit!
  end
end
