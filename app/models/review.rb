class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :shop
  has_many :comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  has_one_attached :review_image

  validates :title, :content, :rate, presence: true
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

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
      self.review_tags.delete ReviewTag.find_by(tag_name: old)
    end
    # 新しいタグを保存
    new_tags.each do |new|
      new_review_tag = ReviewTag.find_or_create_by(tag_name: new)
      self.review_tags << new_review_tag
    end
  end
end
