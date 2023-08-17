# frozen_string_literal: true

module Types
  class TripInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :name, String, required: false
    argument :description, String, required: false
    argument :start_date, GraphQL::Types::ISO8601DateTime, required: false
    argument :end_date, GraphQL::Types::ISO8601DateTime, required: false
    argument :author, Integer, required: true
    argument :created_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :updated_at, GraphQL::Types::ISO8601DateTime, required: false
  end
end
