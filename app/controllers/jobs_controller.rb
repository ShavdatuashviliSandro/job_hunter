class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def refresh
    print 1
    @jobs = Job.order("RANDOM()").limit(5) # fetch random jobs as "new" ones
    render json: @jobs
  end
end
