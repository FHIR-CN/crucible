class TestRun
  include Mongoid::Document
  belongs_to :server
  field :date, type: Time
  field :conformance
  embeds_many :tests, class_name: "Test"

end
