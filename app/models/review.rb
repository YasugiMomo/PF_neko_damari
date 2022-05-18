class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :shop
  has_many :comments, dependent: :destroy

  has_one_attached :review_image

  validates :title, :content, :rate, presence: true
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

  
end
