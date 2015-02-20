class TestResult
  include Mongoid::Document
  embedded_in :testRun
  has_one :test


end
