class MonitorsController < ApplicationController
  # before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def record

	url = URI.parse('http://spark.furore.com/fhir/'+params[:fhir_request])
	req = Net::HTTP.const_get(request.method.titleize.to_sym).new(url.path)
	con = Net::HTTP.new(url.host, url.port)

	body = request.body.read
	req.body = body
	# con.use_ssl = true

	w = {}
	request.env.map {|n| w[n[0]] = n[1].to_s}
	w.to_json
	Mongoid::Sessions.default['monitor_record'].insert w

	req['Content-Type'] = request.env['CONTENT_TYPE']
	req['Accept-Charset'] = request.env['HTTP_ACCEPT_CHARSET']

	x = con.start {|http| http.request(req)}

  	render xml: x.body
  end

end
