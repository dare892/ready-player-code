# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "RUNNING SEEDS-----------"

languages = ['javascript']
languages.each do |language|
  @l = Language.create(name: language)
  (0..4).each do |num|
    (0..2).each do |chal_num|
      @l.challenges.create(
        title: "Sample #{language} challenge #{num+1}-#{chal_num+1}",
        description: 'Do something awesome.',
        difficulty: Challenge.difficulties.keys[num],
        published: true
      )
    end
  end
end

(1..2).each do |n|
  GameMappingGroup.difficulties.keys.each do |difficulty|
    @gmg = GameMappingGroup.create(difficulty: difficulty, language: Language.first)
    challenges = Challenge.where(difficulty: difficulty)
    (0..2).each do |num|
      @gmg.game_mappings.create(
        challenge: challenges[num],
        sort: num
      )
    end
  end
end
