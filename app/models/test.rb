class Test
  include Mongoid::Document
  embedded_in :testResult
  belongs_to :server
  field :resource_class
end
