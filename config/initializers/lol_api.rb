require 'lol'
# $client = Lol::Client.new(ENV['LOL_API'], { region: 'na', redis: "redis://localhost:6379", ttl: 900 })
$client = Lol::Client.new(ENV['LOL_API'], { region: 'na' })
