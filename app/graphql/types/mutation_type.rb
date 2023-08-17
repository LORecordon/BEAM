module Types
  class MutationType < Types::BaseObject
    field :add_post, mutation: Mutations::AddPost
    field :add_trip, mutation: Mutations::AddTrip
    field :add_destination, mutation: Mutations::AddDestination


  end
end
