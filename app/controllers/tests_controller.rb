class TestsController < ApplicationController
  respond_to :json

  def index
    list = []
    index = 0

    # {:ReadTest=>
    #   {:author=>"Crucible::Tests::ReadTest",
    #    :description=>"Initial Sprinkler tests (R001, R002, R003, R004) for testing basic READ requests.",
    #    :title=>"ReadTest",
    #    :tests=>
    #     [:r001_get_person_data_test,
    #      :r002_get_unknown_resource_type_test,
    #      :r003_get_non_existing_resource_test,
    #      :r004_get_bad_formatted_resource_id_test]
    #   }
    # }

    Crucible::Tests::Executor.list_all.each do |k,v|
      list << {id: index+=1, author: v[:author], description: v[:description], title: v[:title], tests: v[:tests]}
    end
    tests = {tests: list}
    respond_with tests.to_json
  end
end