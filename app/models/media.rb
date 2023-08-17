# == Schema Information
#
# Table name: media
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Media < ApplicationRecord
  belongs_to :post


  has_one_attached :file
end
