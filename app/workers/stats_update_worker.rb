class StatsUpdateWorker
  include Sidekiq::Worker

  def perform(summoner_name, stat_id)
    stat = Stat.find(stat_id)
    summoner_id = HTTParty.get("https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/#{summoner_name.gsub(/\s+/, "")}?api_key=#{ENV['LOL_API']}").first[1]['id']
    lolking_profile_url = "http://www.lolking.net/summoner/na/#{summoner_id}"
    tier = HTTParty.get("https://na.api.pvp.net/api/lol/na/v2.5/league/by-summoner/#{summoner_id}/entry?api_key=#{ENV['LOL_API']}").first[1][0]['tier']

    stat.update_attributes( summoner_id: summoner_id,
                lolking_profile_url: lolking_profile_url, tier: tier )

    puts "___COMPLETED_at_#{Time.now}___"
  end
end
