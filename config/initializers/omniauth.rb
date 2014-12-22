Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_key, Rails.application.secrets.google_secret, {
  scope: 'https://www.googleapis.com/auth/drive, email, https://docs.google.com/feeds',
  access_type: 'offline'}
end