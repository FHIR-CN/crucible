module Api
  class TestRunsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    respond_to :json

    def index
      render json: TestRun.all
    end

    def create
      attributes = request_params
      attributes['tests'].each do |test|
        test[:id] = test[:title]
        test[:server_id] = request_params[:server_id]
        test.delete(:title)
      end
      run = TestRun.new(attributes)
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
      params.require(:test_run).permit(:server_id, :date, :resource_class , "tests" => [:title] )
    end

  end
end
