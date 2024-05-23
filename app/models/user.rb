class User < ApplicationRecord
  JSON_OPTIONS = {
    only: ['id', 'name', 'nickname', 'bio', 'created_at'],
    methods: [:profile_image_url]
  }

  has_secure_password

  has_many :posts
  has_many :identities
  has_many :user_mentions

  has_one_attached :profile_image

  validates :password, length: { minimum: 8 }, if: -> { new_record? || !password.nil? }

  validates :nickname, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]+\z/ }, allow_nil: true

  validates :email, uniqueness: true, presence: true

  after_save do
    self.update nickname: "user#{self.id}" unless nickname.present?
  end

  before_validation do
    self.nickname = nickname.try(:downcase)
    self.email = email.try(:downcase)
  end

  def profile_image_url
    if profile_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(profile_image)
    else
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
    end
  end

  def send_password_reset
    UserMailer.with(user: self).password_reset.deliver_now
    puts 'delivered'
  end
end
