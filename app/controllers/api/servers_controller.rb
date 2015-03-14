module Api
  class ServersController < ApplicationController
    respond_to :json

    def index
      if current_user.nil?
        render json: Server.all
      else
        render json: current_user.servers
      end
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
      server = Server.find(params[:id])
      conformance = JSON.parse(FHIR::Client.new(server.url).conformanceStatement.to_json)
      conformance['rest'].each do |rest|
        rest['operation'] = rest['operation'].reduce({}) {|memo,operation| memo[operation['code']]=true; memo}
        rest['results'] = rest['operation'].reduce({}) {|memo,code| memo[code[0]]={:passed => [], :failed => [], :status => ""}; memo}
        rest['resource'].each do |resource|
          resource['operation'] = resource['interaction'].reduce({}) {|memo,operation| memo[operation['code']]=true; memo}
          resource['results'] = resource['interaction'].reduce({}) {|memo,code| memo[code[0]]={:passed => [], :failed => [], :status => ""}; memo}
        end
      end
      render json: {conformance: conformance}
    end

    private

    def server_params
      params.require(:server).permit(:url)
    end
  end
end
