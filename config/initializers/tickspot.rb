Tickspot.configure do |config|
  config.company = ENV['TICK_COMPANY']
  config.email = ENV['TICK_EMAIL']
  config.password = ENV['TICK_PASSWORD']
end