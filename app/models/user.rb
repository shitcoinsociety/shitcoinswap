class User < ApplicationRecord
  include LiveStores

  JSON_OPTIONS = {
    only: ['id', 'name', 'nickname', 'bio', 'created_at'],
    methods: [:profile_image_url]
  }

  PRIVATE_JSON_OPTIONS = {
    only: JSON_OPTIONS[:only] + ['email'],
    methods: JSON_OPTIONS[:methods] + [
      :available_balances, :funds_in_orders, :sgid
    ]
  }

  has_secure_password

  has_many :posts
  has_many :identities
  has_many :user_mentions
  has_many :deposits
  has_many :orders

  has_many :buy_trades, class_name: "Trade", foreign_key: "buying_user_id"
  has_many :sell_trades, class_name: "Trade", foreign_key: "selling_user_id"

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

  def sgid
    to_signed_global_id(expires_in: nil).to_s
  end

  def subscribed
    broadcast_balances
  end

  def broadcast_balances
    livestore('balances').update(available_balances)
  end

  # This method calculates the current balances for the user
  # based on all historical data.
  # Deposits - Withdrawals + Buy Trades - Sell Trades
  # TODO: This is slow. Cache this
  def balances
    Hash.new(0)
      .merge({eur: 0})
      .merge(deposits.group(:symbol).sum(:amount))
      .merge(buy_trades.group(:buy_symbol).sum(:buy_amount)) {|key, v1, v2| v1 + v2} # add this
      .merge(buy_trades.group(:sell_symbol).sum(:sell_amount)) {|key, v1, v2| v1 - v2} # add these
      .merge(sell_trades.group(:buy_symbol).sum(:buy_amount)) {|key, v1, v2| v1 - v2} # subtract this
      .merge(sell_trades.group(:sell_symbol).sum(:sell_amount)) {|key, v1, v2| v1 + v2} # subtract these
      .with_indifferent_access
  end

  def funds_in_orders
    orders.open.group(:sell_symbol).sum(:remaining_sell_amount).with_indifferent_access
  end

  def available_balances
    balances.merge(funds_in_orders) { |_, v1, v2| v1 - v2 }.with_indifferent_access
  end

  def available_balance(symbol)

    available_balances[symbol]
  end
end
