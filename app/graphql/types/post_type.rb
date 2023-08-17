# frozen_string_literal: true

module Types
  class PostType < Types::BaseObject
    graphql_name 'Post'
    description 'A post of a trip'

    field :id, ID
    field :title, String
    field :body, String
    field :trip_id, Integer
    field :author, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime
    field :updated_at, GraphQL::Types::ISO8601DateTime
    field :public, Boolean
    field :destinations, [Types::DestinationType]
    field :users, [Types::UserType]
    # field :media, [Types::ImageType]
    # field :media, [Types::VideoType]
    def destinations
      object.destinations
    end

    def users
      object.users
    end





  end
end
