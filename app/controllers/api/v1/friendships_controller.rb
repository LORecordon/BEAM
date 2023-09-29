class API::V1::FriendshipsController < APIController
    before_action :authenticate_with_api_key!
    before_action :set_user
    before_action :set_friend, only: [:create]

    def userFriends
        if @user
            friendships1 = Friendship.where(user_id: @user)
            friendships2 = Friendship.where(friend_id: @user)
            friendships = friendships1.or(friendships2)
            friendids = friendships.pluck(:user_id, :friend_id).flatten.uniq
            friendids.delete(@user.id)
            @friends = User.where(id: friendids)
            render json: @friends
        else
            render json: {error: "No user"}, status: :unauthorized
        end
    end

    def create
        puts "hhhhhhhhhhhhhhhhhhhhhh"
        ftoken = params[:ftoken]
        token = ftoken.split("-")[0]
        timestamp = ftoken.split("-")[1]
        pt = Time.now.to_i - timestamp.to_i
        if pt > 1.minute.to_i
            render json: {errors: "Expired Token"}
        else 
            @temp = Friendship.new(gps_coordinates: params[:lat], friend_id: @friend.id, user_id: @user.id)
            if @temp.save
                render json: {message: "Friendship Created", friend: @friend}
            else
                render json: {errors: @temp.errors.full_messages, friend: @friend}
            end
        end
    end

    private

    def set_user
        puts "setting user"
        @user = User.where(email: params[:email]).first
    end

    def set_friend
        @friend = User.where(friendship_token: params[:ftoken]).first
    end
end
