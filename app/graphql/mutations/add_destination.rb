module Mutations
  class AddDestination < BaseMutation
    # field :post, Types::PostType, null: false
    field :destination, Types::DestinationType
    field :errors, [String]

    argument :name, String, required: true
    argument :country, String, required: true
    argument :city, String, required: true
    argument :post_id, ID


    def resolve(name:, country:, city:, post_id:)
      post = Post.find(post_id)
      destination = post.destinations.build(name: name, country: country, city: city)
      unless post.nil?
        destination.posts << post
      end

      if destination.save
        # Successful creation, return the created object with no errors
        {
          destination: destination,
          errors: []
        }
      else
        # Failed save, return the errors to the client
        {
          destination: nil,
          errors: destination.errors.full_messages
        }
      end

    end
  end
end
