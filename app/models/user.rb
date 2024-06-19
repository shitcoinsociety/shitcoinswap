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
    # if profile_image.attached?
    #   Rails.application.routes.url_helpers.rails_blob_url(profile_image, only_path: true)
    # else

    gravatar_id = Digest::MD5.hexdigest(email)
    
    "https://www.gravatar.com/avatar/#{gravatar_id}?s=200&d=mp"
    
  end

  def send_password_reset
    UserMailer.with(user: self).password_reset.deliver_now
    puts 'delivered'
  end

  def balances
    return Hash.new(0)
  end

  def locked
    orders.group(:have_symbol).sum(:have_amount)
  end

  def available_balace(symbol)
    # balance minus whatever is locked in orders
    balances[symbol] - orders.where(have_symbol: symbol).sum(:have_amount)
  end
end
