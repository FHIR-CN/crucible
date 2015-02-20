module Api
  class TestRunsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    respond_to :json

    def index
      render json: TestRun.all
    end

    def create
      run = TestRun.new(request_params)
      run.date = Time.now

      if run.save
        respond_with run.as_json({:root => true}), location: api_test_runs_path
      else
        respond_with run, status: 422
      end
    end

    def show
      run = TestRun.find(params[:id])
      respond_with run.as_json({:root => true})
    end

    def update
    end

    def destroy
    end

  private
    def request_params
      params.require(:test_run).permit!
    end

  end
end
