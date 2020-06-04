ActionMailer::Base.smtp_settings = {
  domain: '18.194.249.193',
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain,
  user_name:      'apikey',
  password:       Rails.application.credentials[Rails.env.to_sym][:sendgrid_api_key]
}