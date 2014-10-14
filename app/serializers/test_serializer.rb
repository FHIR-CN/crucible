class TestSerializer < ActiveModel::Serializer
  attributes :id, :author, :description, :title, :tests
end
