module Api
  class TestRunsController < ApplicationController
    respond_to :json

    def show
      render json: {test_run:TestRun.find(params[:id])}
    end


    def create
      run = TestRun.new(run_params)
      run.date = Time.now
      run.user = current_user
      if run.save()
        run = {:test_run => run}
        respond_with run, location: api_test_runs_path
      else
        run = {:test_run => run}
        respond_with run, status: 422
      end
    end

    def index
      @runs = []

      if not current_user.nil?
        @runs = current_user.test_runs
      end
      render json:{test_runs: @runs}
    end

    private
    def run_params
      params.require(:test_run).permit(:date, :conformance, :server_id, "test_results" => [:has_run, :test_id])
    end
  end
end
