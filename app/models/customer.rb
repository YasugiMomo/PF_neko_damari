class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews
  has_many :comments

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      # 作成するときの情報
      customer.password = SecureRandom.urlsafe_base64
      customer.nickname = "ゲスト"
    end
  end
end
