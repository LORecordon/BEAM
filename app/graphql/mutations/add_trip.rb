module Mutations
  class AddTrip < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false
    field :trip, Types::TripType
    field :errors, [String]
    # TODO: define arguments
    # argument :name, String, required: true
    argument :name, String, required: true
    argument :description, String
    argument :start_date, GraphQL::Types::ISO8601DateTime
    argument :end_date, GraphQL::Types::ISO8601DateTime
    argument :author, String, required: true

    # TODO: define resolve method
    def resolve(name:, description:, start_date:, end_date:, author:)
      auth = User.find_by(email: author)
      trip = auth.trips.build(name: name, description: description, start_date: start_date, end_date: end_date, author: auth)
      if trip.save
        # Successful creation, return the created object with no errors
        {
          trip: trip,
          errors: []
        }
      else
        # Failed save, return the errors to the client
        {
          trip: nil,
          errors: trip.errors.full_messages
        }
      end
    end
  end
end

