class API::V1::UsersController < APIController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authenticate_with_api_key!, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1 or /users/1.json
  def show
    render json: @user
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)


    if @user.save
      render @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      render @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.where(email: params[:email]).first

  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.fetch(:user, {}).permit(:id, :email, :first_name, :last_name,
                                   :phone, :password, :avatar)
  end

  def update_params
    params.fetch(:user, {}).permit(:id, :email, :first_name, :last_name,
                                   :phone, :password, :avatar)
  end



end