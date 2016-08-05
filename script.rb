require 'pusher'

pusher = Pusher::Client.new(
  app_id: '6',
  key: '12dd1fd264efba078cfd',
  secret: 'cf0b692aa74c06c637b4',
  host: 'localhost',
  port: 8081,
  encrypted: false
)

puppies = pusher.live_store("puppies")
puppies << "Snoopy"