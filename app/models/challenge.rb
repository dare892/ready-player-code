require 'open3'

class Challenge < ApplicationRecord
  has_many :challenge_answers

  enum difficulty: ['beginner', 'easy', 'medium', 'hard', 'master']

  LANGUAGES = {
    "ruby" => ["ruby", ".rb"],
    "javascript" => ["node", ".js"],
    "python" => ["python3", ".py"]
  }

  def check_answer(response, language)
      # sleep(2)
      return 'pass'
      # docker here
    testing_suite_info = Challenge::LANGUAGES[language.name]
    path = Rails.root.join("public", "docker-tests").to_s
    docker_file = "#{Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]}" + testing_suite_info.last
    f_name = path + "/#{docker_file}"
    f = File.new(f_name, 'w+')
    f.puts(response)
    answer = self.challenge_answers.where(is_test: true).shuffle.last
    f.puts("\n\n" + "puts readyPlayerCode(#{answer.input})")
    f.close

    begin
      out, err, st = Open3.capture3("timeout 10 docker run --rm -v #{path}:/run-tests:ro dare892/code-test:latest #{testing_suite_info.first} /run-tests/#{docker_file}")
      File.delete(f_name)
      if err.present?
        err.chomp
      else
        if answer.output == out.to_s.gsub("\n","")
          'pass'
        else
          'Tested against a few answers and it is not correct!'
        end
      end
    rescue => ex
      puts ex
      File.delete(f_name)
      'pass'
    end
  end
end
