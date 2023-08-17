# frozen_string_literal: true

module Types
  class TripType < Types::BaseObject
    graphql_name 'Trip'
    description 'A trip of a user'

    field :id, ID
    field :name, String
    field :description, String
    field :start_date, GraphQL::Types::ISO8601DateTime
    field :end_date, GraphQL::Types::ISO8601DateTime
    field :created_at, GraphQL::Types::ISO8601DateTime
    field :updated_at, GraphQL::Types::ISO8601DateTime
    field :posts, [Types::PostType]

    def posts
      Post.where(trip: object.id)
    end

    field :destinations, [Types::DestinationType]

    def destinations
      Destination.joins(:posts).where(posts: { trip: object.id })
    end

    field :author, Types::UserType

    def author
      User.find_by(id: object.author)
    end



  end
end
