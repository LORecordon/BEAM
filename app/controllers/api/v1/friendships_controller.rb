class API::V1::FriendshipsController < APIController
    before_action :authenticate_with_api_key!
    before_action :set_user, only: %i[ create ]
    before_action :set_friend, only: %i[ create ]

    def create
        x = Friendship.first
        x.delete
        puts params
        ftoken = params[:ftoken]
        token = ftoken.split("-")[0]
        timestamp = ftoken.split("-")[1]
        pt = Time.now.to_i - timestamp.to_i
        if pt > 100.minute.to_i
            render json: {message: "Expired Token"}
        else 
            @temp = Friendship.new(gps_coordinates: params[:lat], friend_id: @friend.id, user_id: @user.id)
            if @temp.save
                render json: {message: "Friendship Created", friend: @friend}
            else
                render json: {errors: @temp.errors.full_messages, friend: @friend}
            end
        end
    end

    end

    private

    def set_user
        @user = User.where(email: params[:email]).first
    end

    def set_friend
        @friend = User.where(friendship_token: params[:ftoken]).first
end
