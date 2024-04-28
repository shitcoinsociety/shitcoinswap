require 'open-uri'

class Identity < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true
  validates :provider_id, presence: true, uniqueness: { scope: :provider }

  def self.from_omniauth! auth_hash, user
    Identity.where(provider: auth_hash['provider'], provider_id: auth_hash['uid']).first_or_create! do |identity|
      identity.user ||= user || User.where(email: auth_hash['info']['email']).first_or_create!(password: SecureRandom.hex, nickname: auth_hash['info']['nickname'], name: auth_hash['info']['name'])
    end.tap do |identity|
      if !identity.user.profile_image.attached? && auth_hash['info']['image'].present?
        image = URI.parse(auth_hash['info']['image']).open
        identity.user.profile_image.attach(io: image, filename: 'profile.png')
      end
      identity.update provider_info: auth_hash['info']
    end
  end
end
