module Api
  class TestrunsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    respond_to :json

    def index
      render json: Testrun.all
    end

    def create
      run = Testrun.new(request_params)
      run.date = Time.now
      if run.save
        respond_with run, location: api_testruns_path
      else
        respond_with run, status: 422
      end
    end

    def show
      run = Testrun.find(params[:id])
      respond_with run
    end

    def update
    end

    def destroy
    end

  private
    def request_params
      params.require(:testrun).permit(:server_id)
    end

  end
end
