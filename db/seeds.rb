# require 'lol'
#
# client = Lol::Client.new(ENV['LOL_API'], {region: 'na'})

### Sets up Runes ###
# all_runes = client.static.rune.get
# all_rune_ids = all_runes.map { |rune| rune.id }
#
# all_rune_ids.each do |id|
#   puts "Finding Rune: #{id}"
#   rune_data = client.static.rune.get(id, runeData: "all")
#   if rune_data.name.include? "Greater"
#     rune = Rune.find_or_initialize_by(uid: rune_data.id)
#     rune.description = rune_data.sanitizedDescription
#     rune.name = rune_data.name
#     rune.image_name = rune_data.image["full"]
#
#   rune.save!
#   puts "Saved Rune: #{rune.inspect}"
#   end
# end
