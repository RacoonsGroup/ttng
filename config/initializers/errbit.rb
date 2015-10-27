Airbrake.configure do |config|
  config.api_key = '9237190653bd512e61f5ef60b3f5ab0e'
  config.host    = 'errbit.racoons-group.com'
  config.port    = 80
  config.secure  = config.port == 443
end
