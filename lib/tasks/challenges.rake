require 'rake'

namespace :db do
  task challenges: :environment do
    challenges = {
      'javascript'=>{
        'beginner'=>[
          {
            title: 'Beginner Challenge 1', 
            description: "Make a function named readyplayercode() that returns an array of integers from 1 to 1000.",
            answers: nil
          },
          {
            title: 'Beginner Challenge 2', 
            description: "Make a function named readyplayercode() that takes a string and returns an array of each letter.",
            answers: [
              input: 'hello',
              output: "['h','e','l','l','o']"
            ]
          },
          {
            title: 'Beginner Challenge 3', 
            description: "Have the function FirstReverse(str) take the str parameter being passed and return the string in reversed order. For example: if the input string is \"Hello World and Coders\" then your program should return the string sredoC dna dlroW olleH.",
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
        ],
        'easy'=>[
          {
            title: 'Longest Word', 
            description: "Have the function LongestWord(sen) take the sen parameter being passed and return the largest word in the string. If there are two or more words that are the same length, return the first word from the string with that length. Ignore punctuation and assume sen will not be empty.",
          },
        ]}  
      }
    }
    @cha = Challenge.new()
  end
end
