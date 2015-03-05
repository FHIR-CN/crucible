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
        if result.test.resource_class?
          val = { debug: params, results: test.execute(result.test.resource_class.constantize) }
        else
          val = { debug: params, results: test.execute }
        end

        result.has_run = true
        result.result = {id: params[:id], result: val}
        result.save()
        render json: {result: result.result}
      end
    end

  end
end
