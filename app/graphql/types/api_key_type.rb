# frozen_string_literal: true

module Types
  class APIKeyType < Types::BaseObject
    graphql_name 'APIKey'
    description 'Key to access the API'

    field :id, ID
    field :bearer_id, Integer
    field :bearer_type, String
    field :token_digest, String
    field :created_at, GraphQL::Types::ISO8601DateTime
    field :updated_at, GraphQL::Types::ISO8601DateTime
  end
end
