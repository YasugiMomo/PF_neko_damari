class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :shop

  has_one_attached :review_image

  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

end
