module Api
  class TestResultsController < ApplicationController
    def result
      puts "Test Results"
      run = TestRun.where('test_results._id' => BSON::ObjectId.from_string(params[:id])).first
      result = run.test_results.find(params[:id])
      if result.has_run
        render json: {result: result.result}
      else
        client1 = FHIR::Client.new(run.server.url)
        test = Crucible::Tests.const_get(result.test.title).new(client1, nil)
        val = nil
        if result.test.resource_class?
          val = test.execute(result.test.resource_class.constantize)[0]["#{result.test.title}_#{result.test.resource_class.split("::")[1]}"][:tests]
        else
          val = test.execute[0][result.test.name.to_sym][:tests]
        end

        result.has_run = true
        result.result = val
        result.save()
        render json: {results: result.result}
      end
    end

  end
end
