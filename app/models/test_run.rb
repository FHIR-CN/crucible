class TestRun
  include Mongoid::Document
  embeds_many :test_results
  field :conformance
  field :date, type: DateTime
  belongs_to :server
  belongs_to :user
end
