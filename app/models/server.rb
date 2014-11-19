class Server
  include Mongoid::Document
  field :url, type: String
  belongs_to :user
end
