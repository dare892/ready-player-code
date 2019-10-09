# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "DESTROYING ALL OBJECTS-----------"

# reset
ChallengeAnswer.destroy_all
ChallengeGame.destroy_all
Challenge.destroy_all
GameMapping.destroy_all
GameMappingGroup.destroy_all
GameResult.destroy_all
Game.destroy_all
Language.all.destroy_all
Message.destroy_all
Response.destroy_all
RoomUser.destroy_all
Room.destroy_all
User.destroy_all

puts "RUNNING SEEDS-----------"

languages = ['javascript', 'ruby']
languages.each do |language|
  @l = Language.create(name: language)
end

Rake::Task['db:pop_challenges'].invoke
@user = User.create(name: 'Admin', email: 'admin@example.com', password: 'qkrwhdtkd')
