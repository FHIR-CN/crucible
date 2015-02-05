module Api
  class TestsController < ApplicationController
    respond_to :json

    def index
      list = []
      index = 0

      # Receives:

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
      if params[:url] || params[:url1]
        metadata = TEST_METADATA || Crucible::Tests::Executor.generate_metadata
        if params[:url2]
          tests_data = Crucible::Tests::Executor.new(FHIR::Client.new(params[:url1]), FHIR::Client.new(params[:url2])).list_all_with_conformance(params[:multiserver] == 'true', metadata)
        else
          tests_data = Crucible::Tests::Executor.new(FHIR::Client.new params[:url]).list_all_with_conformance(params[:multiserver] == 'true', metadata)
        end
      else
        tests_data = Crucible::Tests::Executor.list_all(params[:multiserver] == 'true')
      end
      tests_data.each do |k,v|
        list << {_id: index+=1}.merge(v)
      end
      tests = {tests: list}
      respond_with JSON.pretty_generate(tests)

      # Returns:

      # http://localhost:3000/tests

      # {
      #   "tests": [
      #     {
      #       "id": 1,
      #       "author": "Crucible::Tests::ReadTest",
      #       "description": "Initial Sprinkler tests (R001, R002, R003, R004) for testing basic READ requests.",
      #       "title": "ReadTest",
      #       "tests": [
      #         "r001_get_person_data_test",
      #         "r002_get_unknown_resource_type_test",
      #         "r003_get_non_existing_resource_test",
      #         "r004_get_bad_formatted_resource_id_test"
      #       ]
      #     }
      #   ]
      # }
    end
  end
end
