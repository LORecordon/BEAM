module Mutations
  class AddPost < BaseMutation
    # TODO: define return fields
    field :post, Types::PostType
    field :errors, [String]
    # TODO: define arguments
    argument :title, String, required: true
    argument :body, String
    argument :public, Boolean
    argument :author, String, required: true
    argument :trip_id, ID


    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
  end
end
