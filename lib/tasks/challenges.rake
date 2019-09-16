require 'rake'

namespace :db do
  task challenges: :environment do
    lib = {
      'beginner'=>[
        {
          title: 'Warmup Challenge',
          description: "Write a function readyPlayerCode(num) that returns an integer that is double the number.",
          answers: [
            {
              input: '1',
              output: '2'
            },
            {
              input: '2',
              output: '4',
              is_test: true
            }
          ]
        },
        {
          title: 'Beginner Challenge 1',
          description: "Make a function named readyPlayerCode(num) where it returns an array of integers from num to 1000. Assume that num will be always smaller than 1000.",
          answers: [
            {
              input: '998',
              output: "['998','999','1000']"
            },
            {
              input: '996',
              output: "['996','997','998','999','1000']",
              is_test: true
            }
          ]
        },
        {
          title: 'Beginner Challenge 2',
          description: "Make a function named readyPlayerCode(str) that takes a string and returns an array of each letter.",
          answers: [
            {
              input: 'hello',
              output: "['h','e','l','l','o']"
            },
            {
              input: 'panda',
              output: "['p','a','n','d','a']",
              is_test: true
            }
          ]
        },
        {
          title: 'Beginner Challenge 3',
          description: "Have the function readyPlayerCode(str) take the str parameter being passed and return the string in reversed order. For example: if the input string is \"Hello World and Coders\" then your program should return the string sredoC dna dlroW olleH.",
          answers: [
            {
              input: "coderbyte",
              output: "etybredoc"
            },
            {
              input: "I Love Code",
              output: "edoC evoL I",
              is_test: true
            }
          ]
        },
        {
          title: 'Beginner Challenge 4',
          description: "Have the function readyPlayerCode(str) take the str parameter being passed and capitalize the first letter of each word. Words will be separated by only one space.",
          answers: [
            {
              input: "hello world",
              output: "Hello World"
            },
            {
              input: "i ran there",
              output: "I Ran There",
              is_test: true
            }
          ]
        },
      ],
      'easy'=>[
        {
            title: 'Simple Symbols',
            description: "Have the function readyPlayerCode(str) take the str parameter being passed and determine if it is an acceptable sequence by either returning the string true or false. The str parameter will be composed of + and = symbols with several characters between them (ie. ++d+===+c++==a) and for the string to be true each letter must be surrounded by a + symbol. So the string to the left would be false. The string will not be empty and will have at least one letter.",
            answers: [
              {
                input: '+d+=3=+s+',
                output: 'true'
              },
              {
                input: 'f++d+',
                output: 'false'
              },
              {
                input: '+a+=+=+d+',
                output: 'true',
                is_test: true
              },
              {
                input: '+a+=+=+d',
                output: 'false',
                is_test: true
              }
            ]
        },
        {
          title: 'AlphabetSoup',
          description: "Have the function readyPlayerCode(str) take the str string parameter being passed and return the string with the letters in alphabetical order (ie. hello becomes ehllo). Assume numbers and punctuation symbols will not be included in the string.",
          answers: [
            {
              input: 'coderbyte',
              output: 'bcdeeorty'
            },
            {
              input: 'hooplah',
              output: 'ahhloop',
              is_test: true
            }
          ]
        },
        {
          title: 'Question Marks',
          description: "Have the function QuestionsMarks(str) take the str string parameter, which will contain single digit numbers, letters, and question marks, and check if there are exactly 3 question marks between every pair of two numbers that add up to 10. If so, then your program should return the string true, otherwise it should return the string false. If there aren't any two numbers that add up to 10 in the string, then your program should return false as well.
          For example: if str is \"arrb6???4xxbl5???eee5\" then your program should return true because there are exactly 3 question marks between 6 and 4, and 3 question marks between 5 and 5 at the end of the string.
          ",
          answers: [
            {
              input: 'acc?7??sss?3rr1??????5',
              output: 'true'
            },
            {
              input: 'acc?4??sss?6rr1??????5',
              output: 'true',
              is_test: true
            },
            {
              input: 'acc?3??sss?6rr1??????5',
              output: 'false',
              is_test: true
            }
          ]
        },
        {
          title: 'Kaprekars Constant',
          description: "Have the function KaprekarsConstant(num) take the num parameter being passed which will be a 4-digit number with at least two distinct digits. Your program should perform the following routine on the number: Arrange the digits in descending order and in ascending order (adding zeroes to fit it to a 4-digit number), and subtract the smaller number from the bigger number. Then repeat the previous step. Performing this routine will always cause you to reach a fixed number: 6174. Then performing the routine on 6174 will always give you 6174 (7641 - 1467 = 6174). Your program should return the number of times this routine must be performed until 6174 is reached. For example: if num is 3524 your program should return 3 because of the following steps: (1) 5432 - 2345 = 3087, (2) 8730 - 0378 = 8352, (3) 8532 - 2358 = 6174.",
          answers: [
            {
              input: '2111',
              output: '5'
            },
            {
              input: '9831',
              output: '7',
              is_test: true
            }
          ]
        }
      ]
    }

    lib.each do |difficulty, challenges|
      challenges.each_with_index do |challenge, index|
        @cha = Challenge.new(difficulty: difficulty, title: challenge[:title], description: challenge[:description], published: true)
        if @cha.save
          challenge[:answers].each do |answer|
            @cha.challenge_answers.create(input: answer[:input], output: answer[:output], is_test: answer[:is_test])
          end
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
            per_dif = 3
          when 'easy'
            per_dif = 2
          else
            per_dif = 1
          end
          Challenge.where("difficulty = #{dif}").shuffle.last(per_dif).each_with_index do |chal, index|
            @gmg.game_mappings.create(challenge: chal, sort: index)
          end
        end
      end
    end
  end
end
