module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :posts, [Types::PostType]
    field :post, Types::PostType do
      argument :id, ID, required: true
    end

    field :users, [Types::UserType]
    field :user, Types::UserType do
      argument :email, String, required: true
    end

    field :trips, [Types::TripType]
    field :trip, Types::TripType do
      argument :id, ID, required: true
    end

    field :destinations, [Types::DestinationType]
    field :destination, Types::DestinationType do
      argument :id, ID, required: true
    end



    def posts
      Post.all
    end

    def post(id:)
      Post.find_by(id: id)
    end

    def users
      User.all
    end

    def user(email:)
      User.find_by(email: email)
    end

    def trips
      Trip.all
    end

    def trip(id:)
      Trip.find(id)
    end

    def destinations
      Destination.all
    end

    def destination(id:)
      Destination.find(id)
    end

  end
end
