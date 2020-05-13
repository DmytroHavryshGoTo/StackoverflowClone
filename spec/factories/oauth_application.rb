# frozen_string_literal: true

FactoryBot.define do
  factory :access_token, class: "Doorkeeper::AccessToken" do
    resource_owner_id { create(:user).id }
    application
    expires_in { 2.hours }
  end

  factory :application, class: "Doorkeeper::Application" do
    sequence(:name) { |n| "Application #{n}" }
    redirect_uri { "urn:ietf:wg:oauth:2.0:oob" }
    uid { '12345678' }
    secret { '87654321' }
    scopes { 'public' }
  end
end
