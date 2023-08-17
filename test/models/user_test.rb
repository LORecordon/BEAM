# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  description     :text
#  dob             :date
#  email           :string           not null
#  first_name      :string
#  last_name       :string
#  password_digest :string           not null
#  phone           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
