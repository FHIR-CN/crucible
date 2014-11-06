class Server
  include Mongoid::Document
  field :ip, type: String
  belongs_to :user
end
