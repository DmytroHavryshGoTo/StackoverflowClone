# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook]

  has_many :answers
  has_many :questions
  has_many :authorizations
  validates :first_name, :last_name, presence: true

  scope :all_except, ->(user) { where.not(id: user) }

  def self.find_for_oauth(auth)
    authorization = Authorization.where(uid: auth[:uid].to_s, provider: auth[:provider]).first
    return authorization.user if authorization

    email = auth.info[:email]
    user = User.where(email: email).first

    unless user
      password = Devise.friendly_token[0,10]
      first_name, last_name = auth.info[:name].split(' ')
      user = User.create!(email: email, first_name: first_name, last_name: last_name, password: password, password_confirmation: password, confirmed_at: Time.now, created_at: Time.now)
    end

    user.authorizations.create(provider: auth[:provider], uid: auth[:uid].to_s)
    user
  end
end
