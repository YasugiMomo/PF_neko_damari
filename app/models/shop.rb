class Shop < ApplicationRecord
  has_many :reviews, dependent: :destroy

  has_one_attached :shop_image

  attr_accessor :average

  def get_shop_image(width, height)
    unless shop_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      shop_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    shop_image.variant(resize_to_limit: [width, height]).processed
  end

  # 検索機能
  def self.looks(word)
    @shop = Shop.where("name LIKE?","%#{word}%")
  end

  # 絞り込み機能
  # 評価が高い順
  scope :star_count_desc, -> {order(avg_rate: :desc)}
  # 評価が低い順
  scope :star_count_asc, -> {order(avg_rate: :asc)}

  # レビューの平均点
  def avg_rate
    unless self.reviews.empty?
      reviews.average(:rate).round(1).to_f
    else
      0.0
    end
  end

  def review_rate_percentage
    unless self.reviews.empty?
      reviews.average(:rate).round(1).to_f*100/5
    else
      0.0
    end
  end

end
