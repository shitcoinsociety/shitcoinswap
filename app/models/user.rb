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

  validates :nickname, uniqueness: true, presence: true, format: { with: /\A[a-zA-Z0-9_]+\z/ }
  validates :name, presence: true
  validates :email, uniqueness: true, presence: true

  before_validation do
    self.nickname = nickname&.downcase
    self.email = email&.downcase
  end

  def profile_image_url
    if profile_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(profile_image)
    end
  end
end
