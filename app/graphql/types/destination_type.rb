# frozen_string_literal: true

module Types
  class DestinationType < Types::BaseObject
    graphql_name 'Destination'
    description 'A destination of a trip'

    field :id, ID
    field :country, String
    field :city, String
    field :created_at, GraphQL::Types::ISO8601DateTime
    field :updated_at, GraphQL::Types::ISO8601DateTime
    field :latitude, Float
    field :longitude, Float
    field :name, String
    field :posts, [Types::PostType]
  end
end
