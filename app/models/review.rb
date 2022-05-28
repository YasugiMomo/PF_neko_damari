class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :shop
  has_many :comments, dependent: :destroy
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps
  has_many :favorites, dependent: :destroy

  has_many_attached :review_images

  validates :title, :content, presence: true
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

  # def get_review_images(width, height)
  #   unless review_images.attached?
  #     file_path = Rails.root.join('app/assets/images/no_image.jpg')
  #     review_images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  #   end
  #   review_images.variant(resize_to_limit: [width, height]).processed
  # end

  # いいね機能
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  # 絞り込み機能
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(rate: :desc)}

  # タグ付け機能
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    # 古いタグ(既に存在しているタグ)を削除
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end
    # 新しいタグを保存
    new_tags.each do |new|
      new_review_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_review_tag
    end
  end
end
