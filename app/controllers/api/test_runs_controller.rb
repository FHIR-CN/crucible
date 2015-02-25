module Api
  class TestRunsController < ApplicationController
    respond_to :json

    def index
      @runs = TestRun.all
      render json:{test_runs: @runs}
    end
  end
end
