class TestResult
  include Mongoid::Document
  belongs_to :test
  embedded_in :test_run
  field :has_run, type: Boolean, default: false
  field :result
end
