class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :shop

  has_one_attached :review_image
end
