require 'open-uri'

class Identity < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true
  validates :provider_id, presence: true, uniqueness: { scope: :provider }

  def self.from_omniauth! auth_hash, user
    Identity.where(provider: auth_hash['provider'], provider_id: auth_hash['uid']).first_or_create! do |identity|
      identity.user ||= user || User.where(email: auth_hash['info']['email']).first_or_create!(password: SecureRandom.hex, name: auth_hash['info']['name']) do |new_user|
        # set nickname to provider nickname, but only if its not taken
        new_user.nickname = auth_hash['info']['nickname'] unless User.where(nickname: auth_hash['info']['nickname']).exists?
      end
    end.tap do |identity|
      if !identity.user.profile_image.attached? && auth_hash['info']['image'].present?
        image = URI.parse(auth_hash['info']['image']).open
        identity.user.profile_image.attach(io: image, filename: 'profile.png')
      end
      identity.update provider_info: auth_hash['info']
    end
  end
end
