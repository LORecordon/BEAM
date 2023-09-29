class API::V1::PostsController < APIController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_with_api_key!


  def new
    @post = Post.new
  end

  def create
    @post = Post.new()
    author = User.find_by(email: params[:author])
    @post.author = author
    trip = Trip.find(params[:trip_id])
    @post.trip = trip
    if @post.save
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
  end

  def index
    @posts = Post.where(trip_id: params[:trip_id])
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def update
    if @post.update(post_params)
      render :show, status: :ok, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end

  end

  def images
    @post = Post.find(params[:id])
    @images = @post.files

    render json: @images.map { |image| url_for(image)}, status: :ok
  end

  def attachImg
    puts params
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end
  # Only allow a list of trusted parameters through.
  # #TODO: More params like users, destinations, photos, etc.
  def post_params
    params.fetch(:post, {}).permit(:id, :trip_id, :title, :description, :author, :public, :files, destination: [:id, :name, :latitude, :longitude, :country, :city, :trip_id])
  end

  def update_params

    params.fetch(:post, {}).permit(:id, :trip_id, :title, :description, :author, :public, :files, destination: [:id, :name, :latitude, :longitude, :country, :city, :trip_id])
  end



end
