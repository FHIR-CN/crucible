class Test
  include Mongoid::Document
  embedded_in :testResult
end
