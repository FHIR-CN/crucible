module Api
  class TestsController < ApplicationController
    respond_to :json

    def index
      @tests = Test.all
      render json:{test: @tests}
    end
  end
end
