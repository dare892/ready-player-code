require 'open3'

class PagesController < ApplicationController
  access :user => [:single],
         :all => [:index]
  def index

  end

  def single
    # @challenges = Challenge.all.order(:difficulty)
  end

  def test
    # response = params[:response]
    # debugger
    response = "def readyPlayerCode(val) \n\n return val*2 \n end"
    testing_suite_info = Challenge::AVAILABLE_LANGUAGES['ruby']
    path = Rails.root.join("public", "docker-tests").to_s
    docker_file = "#{Time.now.to_i}_#{User.first.session_hash}" + testing_suite_info.last
    f_name = path + "/#{docker_file}"
    f = File.new(f_name, 'w+')
    f.puts(response)
    # if submitted_language == challenge.language && challenge.test_suite.present?
    f.puts("\n\n" + "puts readyPlayerCode(1)")
     # \n puts readyPlayerCode(2)")
    # end
    f.close

    out, err, st = Open3.capture3("timeout 10 docker run --rm -v #{path}:/run-tests:ro test2 #{testing_suite_info.first} /run-tests/#{docker_file}")
    # out, err, st = Open3.capture3("timeout 10 docker run --rm -v #{path}:/run-tests:ro dare892/test:test #{testing_suite_info.first} /run-tests/#{docker_file}")
    # out, err, st = Open3.capture3("timeout 10 docker run --rm -v #{path}:/run-tests:ro sawohol/nikola_applicant_code_tester:0.0.1 #{testing_suite_info.first} /run-tests/#{docker_file}")
    File.delete(f_name)
    @result = (err.present? ? err : out).chomp
    # ActionCable.server.broadcast "live_code_#{data["token"]}", {
    #   output: (err.present? ? err : out).chomp
    # }
  end
end
