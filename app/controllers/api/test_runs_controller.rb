module Api
  class TestRunsController < ApplicationController
    respond_to :json

    def show
      render json: {test_run:TestRun.find(params[:id])}
    end


    def create
      run = TestRun.new(run_params)
      run.date = Time.now
      if run.save()
        respond_with run, location: api_test_runs_path
      else
        respond_with run, status: 422
      end
    end

    def index
      @runs = TestRun.all
      render json:{test_runs: @runs}
    end

    private
    def run_params
      params.require(:test_run).permit(:date, :conformance, :server, "test_results" => [:has_run, :test_id])
    end
  end
end
