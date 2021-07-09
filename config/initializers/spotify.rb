if Rails.application.credentials.dig(:spotify, :client_id) || Rails.application.credentials.dig(:spotify, :client_secret)
  RSpotify.authenticate(Rails.application.credentials.dig(:spotify, :client_id), Rails.application.credentials.dig(:spotify, :client_secret))
else
  puts "! please add `spotify_key` and `spotify_secret` to your config/application.yml file to enable Spotify support".yellow
end