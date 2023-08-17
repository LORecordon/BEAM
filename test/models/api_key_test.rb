# == Schema Information
#
# Table name: api_keys
#
#  id           :integer          not null, primary key
#  bearer_type  :string           not null
#  token_digest :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  bearer_id    :integer          not null
#
# Indexes
#
#  index_api_keys_on_bearer_id_and_bearer_type  (bearer_id,bearer_type)
#  index_api_keys_on_token_digest               (token_digest) UNIQUE
#
require "test_helper"

class APIKeyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
