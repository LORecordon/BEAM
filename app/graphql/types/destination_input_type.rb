# frozen_string_literal: true

module Types
  class DestinationInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :country, String, required: false
    argument :city, String, required: false
    argument :created_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :updated_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :latitude, Float, required: false
    argument :longitude, Float, required: false
    argument :name, String, required: false
    argument :post_id, ID, required: true
  end
end
