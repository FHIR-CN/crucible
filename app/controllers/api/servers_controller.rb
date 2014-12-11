module Api
  class ServersController < ApplicationController
    before_action :authenticate_user!
    skip_before_filter :verify_authenticity_token
    respond_to :json

    def index
      render json: current_user.servers
    end

    def create
      server = Server.new(server_params)
      server.user = current_user
      if server.save
        respond_with server, location: api_servers_path
      else
        respond_with server, status: 422
      end
    end

    def show
      server = Server.find(params[:id])
      respond_with server
    end

    def update
      server = Server.find(params[:id])
      server.update(server_params)
      if server.save
        respond_with server, location: api_servers_path
      else
        respond_with server, status: 422
      end
    end

    def destroy
      server = Server.find(params[:id])
      server.destroy

      respond_with server, location: api_servers_path
    end

    def conformance
      conformance = JSON.parse(FHIR::Client.new(params[:url]).conformanceStatement.to_json)
      conformance['rest'].each do |rest|
        rest['operation'] = rest['operation'].reduce({}) {|memo,operation| memo[operation['code']]=true; memo}
        rest['resource'].each do |resource| 
          resource['operation'] = resource['operation'].reduce({}) {|memo,operation| memo[operation['code']]=true; memo}
        end
      end
      render json: conformance
    end

  private
    def server_params
      params.require(:server).permit(:url)
    end

  end
end
