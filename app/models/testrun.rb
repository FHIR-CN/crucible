class Testrun
  include Mongoid::Document
  belongs_to :server
  field :date, type: Date
  embeds_many :testresults
end
