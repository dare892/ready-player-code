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
    @l.challenges.create(
      title: "Sample #{language} challenge #{num+1}",
      description: 'Do something awesome.',
      difficulty: Challenge.difficulties.keys[num],
      published: true
    )
  end
end
