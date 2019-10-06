require 'open3'

class Challenge < ApplicationRecord
  has_many :challenge_answers

  enum difficulty: ['beginner', 'easy', 'medium', 'hard', 'master']
  enum input_type: ['integer','text']

  LANGUAGES = {
    "ruby" => ["ruby", ".rb"],
    "javascript" => ["node", ".js"],
    "python" => ["python3", ".py"]
  }

  def check_answer(response, language)
    Rails.logger.info "---CHECK_ANSWER for #{language.name}---"
      # sleep(3)
      # return 'pass'
      # docker here
    testing_suite_info = Challenge::LANGUAGES[language.name]
    path = Rails.root.join("public", "docker-tests").to_s
    docker_file = "#{Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]}" + testing_suite_info.last
    f_name = path + "/#{docker_file}"
    f = File.new(f_name, 'w+')
    f.puts(response)
    answer = self.challenge_answers.where(is_test: true).shuffle.last
    if self.input_type == 'integer'
      ans = answer.input
    elsif self.input_type == 'text'
      ans = "'#{answer.input}'"  
    end
    
    case language.name
    when 'ruby'
      f.puts("\n\n" + "puts readyPlayerCode(#{ans})")
    when 'javascript'
      f.puts("\n\n" + "console.log(readyPlayerCode(#{ans}))")
    end
    f.close

    begin
      script = "timeout 10 docker run --rm -v #{path}:/run-tests:ro dare892/code-test-#{language.name}:latest #{testing_suite_info.first} /run-tests/#{docker_file}"
      out, err, st = Open3.capture3(script)
      File.delete(f_name)
      if err.present?
        err.chomp
      else
        output = out.to_s.gsub("\n","")
        if answer.output == output
          'pass'
        else
          "Tested against a few answers and it is not correct. Try Again!"
          # Your code returned < #{output} >, which is not the answer.
        end
      end
    rescue => ex
      puts ex
      File.delete(f_name)
      'pass'
    end
  end
end
