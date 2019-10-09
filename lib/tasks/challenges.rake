require 'rake'

namespace :db do
  task pop_challenges: :environment do
    lib = {
      'beginner' => [],
      'easy' => []
      # 'medium' => [],
      # 'hard' => [],
      # 'master' => []
    }
    
    lib.each do |dif, arr|
      Dir.foreach(Rails.root.join("lib", "tasks","challenges", dif)) do |filename|
        next if filename == '.' or filename == '..'
        begin
          data = JSON.parse(File.read(Rails.root.join("lib", "tasks","challenges", dif, filename)))
          lib[dif] << data
        rescue => ex
          puts ">>>>>>>>ERROR READING FILE : #{dif} : #{filename} : #{ex}"
        end
      end
    end

    lib.each do |difficulty, challenges|
      challenges.each_with_index do |challenge, index|
        @cha = Challenge.new(difficulty: difficulty, title: challenge['title'], description: challenge['description'],input_type: challenge['input_type'], published: true)
        if @cha.save
          challenge['answers'].each do |answer|
            @cha.challenge_answers.create(input: answer['input'], output: answer['output'], is_test: answer['is_test'])
          end
          puts ">>>>>>>>>>CREATED CHALLENGE <#{difficulty}> : #{challenge['title']}"
        else
          puts ">>>>>>>>>>ERROR"
          puts cha.errors.full_messages.join(",")
        end
      end

      (1..3).each do |num|
        @gmg = GameMappingGroup.create(difficulty: difficulty)
        (0..GameMappingGroup.difficulties[difficulty]).each do |dif|
          case difficulty
          when 'beginner'
            per_difficulty = 2
          when 'easy'
            per_difficulty = 1
          else
            per_difficulty = 1
          end
          Challenge.where("difficulty = #{dif}").shuffle.last(per_difficulty).each_with_index do |chal, index|
            @gmg.game_mappings.create(challenge: chal, sort: index)
          end
        end
      end
    end
  end
  
  task validator: :environment do
    lib = {
      'beginner' => [],
      'easy' => []
      # 'medium' => [],
      # 'hard' => [],
      # 'master' => []
    }
    lib.each do |dif, arr|
      Dir.foreach(Rails.root.join("lib", "tasks","challenges", dif)) do |filename|
        next if filename == '.' or filename == '..'
        begin
          data = JSON.parse(File.read(Rails.root.join("lib", "tasks","challenges", dif, filename)))
          lib[dif] << data
        rescue => ex
          puts ">>>>>>>>ERROR READING FILE : #{dif} : #{filename} : #{ex}"
          abort('Please fix the errors')
        end
      end
    end
    puts ">>>>>>>>>> GOOD JOB! ALL CHALLENGE FILES ARE VALID. >>>>>>>>>>>"  
  end
end
