module Api
  class TestsController < ApplicationController
    respond_to :json

    def index
      @tests = Test.all
      render json:{test: @tests}
    end
    def show
      render json: {test:Test.find(params[:id])}
    end
  end
end
