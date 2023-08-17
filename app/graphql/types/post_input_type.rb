# frozen_string_literal: true

module Types
  class PostInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :title, String, required: false
    argument :body, String, required: false
    argument :trip_id, Integer, required: false
    argument :author, Integer, required: false
    argument :created_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :updated_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :public, Boolean, required: false
  end


end
