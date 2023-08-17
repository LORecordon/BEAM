# frozen_string_literal: true

module Types
  class UserInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :email, String, required: true
    argument :password_digest, String, required: true
    argument :created_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :updated_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :dob, GraphQL::Types::ISO8601Date, required: false
    argument :description, String, required: false
    argument :phone, String, required: false

  end
end
