class TestResult
  include Mongoid::Document
  embedded_in :TestRun
  has_one :Test
  

end
