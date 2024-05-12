class User < ApplicationRecord
  JSON_OPTIONS = {
    only: ['id', 'name', 'nickname', 'created_at'],
    methods: [:profile_image_url]
  }

  has_secure_password

  has_many :posts
  has_many :identities
  has_many :user_mentions

  has_one_attached :profile_image

  validates :password, length: { minimum: 8 }, if: -> { new_record? || !password.nil? }

  validates :nickname, uniqueness: true, presence: true, format: { with: /\A[a-zA-Z0-9_]+\z/ }

  validates :email, uniqueness: true, presence: true

  before_validation do
    self.nickname = nickname.try(:downcase) || "user#{id}"
    self.email = email&.downcase
  end

  def profile_image_url
    if profile_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(profile_image)
    end
  end

  def send_password_reset
    UserMailer.with(user: self).password_reset.deliver_now
    puts 'delivered'
  end
end
