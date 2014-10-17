require 'lol'

client = Lol::Client.new(ENV['LOL_API'], {region: 'na'})

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

### Sets up Items ###
all_items = client.static.item.get
all_item_ids = all_items.map { |item| item.id }

all_item_ids.each do |id|
  puts "Finding Item: #{id}"
  item_data = client.static.item.get(id, itemData: "all")

  item = Item.find_or_initialize_by(uid: item_data.id)
  item.description = item_data.sanitizedDescription
  item.name = item_data.name
  item.image_name = item_data.image["full"]

  item.save!
  puts "Saved Item: #{item.inspect}"
end

### Set up SummonerSpells ###
all_sum_spells = client.static.summoner_spell.get
all_sum_spell_ids = all_sum_spells.map { |spell| spell.id }

all_sum_spell_ids.each do |id|
  puts "Finding Summoner Spell: #{id}"
  sum_spell_data = client.static.summoner_spell.get(id, spellData: "all")

  sum_spell = SummonerSpell.find_or_initialize_by(uid: sum_spell_data.id)
  sum_spell.description = sum_spell_data.description
  sum_spell.name = sum_spell_data.name
  sum_spell.image_name = sum_spell_data.key

  sum_spell.save!
  puts "Saved Summoner Spell: #{sum_spell.inspect}"
end

### Set up Masteries ###
# all_masteries = client.static.mastery.get
# all_mastery_ids = all_masteries.map { |mastery| mastery.id }
#
# all_mastery_ids.each do |id|
#   puts "Finding Mastery: #{id}"
#   mastery_data = client.static.mastery.get(id, masteryData: "all")
#
#   mastery = Mastery.find_or_initialize_by(uid: mastery_data.id)
#   mastery.description = mastery_data.sanitizedDescription
#   mastery.name = mastery_data.name
#   mastery.image_name = mastery_data.image["full"]
#
#   mastery.save!
#   puts "Saved Mastery: #{mastery.inspect}"
# end
