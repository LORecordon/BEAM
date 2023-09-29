class API::V1::FriendshipTokensController < APIController
    before_action :authenticate_with_api_key!
    before_action :set_user, only: %i[ show ]


    def idk
        ftoken = generate_FToken
        user = User.where(email: params[:email]).first
        user.update(friendship_token: ftoken)
        render json: {friendship_token: ftoken}
    end

    def show
        #Create friendtoken with current time, generate qrcode and send it
        generate_FToken
        update_FToken
        frontendpoint = "http://localhost:7890"
        qrcode = RQRCode::QRCode.new(frontendpoint + "/#?friendshipToken=" + @FToken.to_str)
        png = qrcode.as_png(size: 300)
        IO.binwrite("tmp/nose1.png", png)
        png = File.read("tmp/nose1.png")
        system "rm tmp/nose1.png"
        send_data png, type: "image/png", disposition: "attachment"
    end

    private

    def generate_FToken
        token = SecureRandom.hex(16)
        timestamp = Time.now.to_i
        @FToken = "#{token}-#{timestamp}"
    end
    def update_FToken
        @user.update(friendship_token: @FToken)
    end

    def set_user
        @user = User.where(email: params[:email])
    end
end
