# Jobs controller
class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def refresh
    jobs = fetch_jobs
    data = create_jobs(jobs['data'])
    render json: { data:, success: 200 }
  end

  def example_fetch
    url = URI('https://jsonplaceholder.typicode.com/todos/')
    response = Net::HTTP.get(url)
    todos = JSON.parse(response)

    sample_payloads = todos.first(10).map(&:to_json)
    dictionary = Zstd::DictTrainer.train(sample_payloads.map(&:bytes), 1024)

    # Save dictionary to file (optional)
    File.write('shared_dict.zstd', dictionary)
  end

  private

  def fetch_jobs
    token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJzYW5kcm8uc2hhdkBnbWFpbC5jb20iLCJwZXJtaXNzaW9ucyI6InVzZXIiLCJjcmVhdGVkX2F0IjoiMjAyNS0wOS0xMVQxOTowMDowOC45ODYyODcrMDA6MDAifQ.zgkBgQgnsNIeDiEWSP5jzpUxyTeIDEo8N8AsycQWknU'
    url = URI('https://api.theirstack.com/v1/jobs/search')

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request['Content-Type'] = 'application/json'
    request['Authorization'] = "Bearer #{token}"
    request.body = "{\"page\": 0,\n  \"limit\": 25,\n  \"job_country_code_or\": [\n    \"US\"\n  ],\n  \"posted_at_max_age_days\": 7}"

    response = http.request(request)

    JSON.parse(response.read_body)
  end

  def create_jobs(jobs)
    jobs.each do |job|
      Job.create(title: job['job_title'], company: job['company'], description: job['description'], link: job['url'])
    end

    Job.all
  end
end
