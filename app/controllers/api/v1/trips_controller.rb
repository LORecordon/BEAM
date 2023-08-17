class API::V1::TripsController < APIController
  before_action :set_trip, only: %i[ show edit update destroy ]
  before_action :authenticate_with_api_key!

  def new
    @trip = Trip.new
  end
  # POST /requests or /requests.json
  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      json render :show, status: :created, location: @trip
    else
      json render json: @trip.errors, status: :unprocessable_entity
    end

  end

  def show
    @trip = Trip.find(params[:id])
    render json: @trip
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @trip.destroy
  end

  def index
    if params[:search]
      puts params[:search]
      strips = Trip.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      ptrips = Trip.joins(:posts).where("posts.body LIKE ?", "%#{params[:search]}%")
      @trips = strips + ptrips
    else
      @trips = Trip.all
    end
    render json: @trips
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def trip_params
    params.fetch(:trip, {}).permit(:id, :name, :description, :start, :end, :author )
  end

  def update_params

    params.fetch(:trip, {}).permit(:id, :name, :description, :start, :end, :author )
  end



end
