# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    graphql_name 'User'
    description 'A user of the app'

    field :id, ID
    field :email, String
    field :password_digest, String
    field :created_at, GraphQL::Types::ISO8601DateTime
    field :updated_at, GraphQL::Types::ISO8601DateTime
    field :first_name, String
    field :last_name, String
    field :dob, GraphQL::Types::ISO8601Date
    field :description, String
    field :phone, String
    field :trips, [Types::TripType]
    field :posts, [Types::PostType]
    field :destinations, [Types::DestinationType]

    def trips
      Trip.where(author: object.id)
    end

    def posts
      Post.where(author: object.id)
    end

    def destinations
      Destination.joins(:posts).where(posts: { author: object.id })
    end





  end




end
