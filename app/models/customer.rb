class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :profile_image

  validates :nickname,
    length: { minimum: 1, maximum: 20 }

  validates :email, presence: true


   # 検索機能
  def self.looks(word)
    @customer = Customer.where("nickname LIKE?","%#{word}%")
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      # 作成するときの情報
      customer.password = SecureRandom.urlsafe_base64
      customer.nickname = "ゲスト"
    end
  end
end
