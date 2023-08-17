class APILabsSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
  max_depth 15
  max_complexity 300
  default_max_page_size 20

  # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
  # use GraphQL::Dataloader
  # use GraphQL::Execution::Interpreter
  # use GraphQL::Analysis::AST

  # GraphQL-Ruby calls this when something goes wrong while running a query:
  def self.type_error(err, context)
    super
  end

  # Union and Interface Resolution
  def self.resolve_type(abstract_type, obj, ctx)
    case obj
    when User
      Types::UserType
    when Post
      Types::PostType
    when Trip
      Types::TripType
    when Destination
      Types::DestinationType
    when APIKey
      Types::APIKeyType
    # when Array
    #   resolve_type(abstract_type, obj.first, ctx)
    else
      raise("Unexpected object: #{obj}")
    end
  end




  # Stop validating when it encounters this many errors:
  validate_max_errors(100)

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition, query_ctx)
    # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
    object.to_gid_param
  end

  rescue_from(ActiveRecord::RecordNotFound) { 'Not found' }

  # Given a string UUID, find the object
  def self.object_from_id(global_id, query_ctx)
    # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
    GlobalID.find(global_id)
  end
end





