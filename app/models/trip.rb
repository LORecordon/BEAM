# == Schema Information
#
# Table name: trips
#
#  id          :integer          not null, primary key
#  author      :integer          not null
#  description :text
#  end_date    :datetime
#  name        :string
#  start_date  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_trips_on_author  (author)
#
class Trip < ApplicationRecord

  has_many :posts
  has_many :destinations, through: :posts
  has_many :users, through: :posts
  belongs_to :user, class_name: "User", foreign_key: "author"



  def post_count
    self.posts.size
  end

  def user_count
    self.users.size
  end

  def destination_count
    self.destinations.size
  end

  def post_mas1
    self.posts.size > 1
  end





end
