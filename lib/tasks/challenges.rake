require 'rake'

namespace :db do
  task challenges: :environment do
    challenges = {
      'javascript'=>{
        'beginner'=>[
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
                output: "edoC evoL I"
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
        ]
      }
    }
    
    challenges.each do |lang, dif|
      @lang = Language.find_or_create_by(name: lang)
      dif.each do |difficulty, challenges|
        challenges.each do |challenge|
          @cha = Challenge.new(language: @lang, difficulty: difficulty, title: challenge[:title], description: challenge[:description])
          if @cha.save
            challenge[:answers].each do |answer|
              @cha.challenge_answers.create(input: answer[:input], output: answer[:output], is_test: answer[:is_test])
            end
          else
            puts ">>>>>>>>>>ERROR"
            puts @cha.errors.full_messages.join(",")
          end
        end
      end
    end
  end
end
