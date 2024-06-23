class User < ApplicationRecord
  JSON_OPTIONS = {
    only: ['id', 'name', 'nickname', 'bio', 'created_at'],
    methods: [:profile_image_url]
  }

  PRIVATE_JSON_OPTIONS = {
    only: JSON_OPTIONS[:only] + ['email'],
    methods: JSON_OPTIONS[:methods] + ['available_balances', 'funds_in_orders']
  }

  has_secure_password

  has_many :posts
  has_many :identities
  has_many :user_mentions
  has_many :deposits
  has_many :orders

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
    { eur: 0 }.merge(deposits.group(:symbol).sum(:amount)).transform_keys(&:to_sym)
  end

  def funds_in_orders
    orders.group(:sell_symbol).sum(:sell_amount).transform_keys(&:to_sym)
  end

  def available_balances
    balances.merge(funds_in_orders) { |_, v1, v2| v1 - v2 }.with_indifferent_access
  end

  def available_balance(symbol)
    # balance minus whatever is locked in orders
    available_balances[symbol]
  end
end
