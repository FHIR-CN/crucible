stored_tests = Test.all.to_a.map {|t| t.name}

( Crucible::Tests::Executor.list_all(true).merge( Crucible::Tests::Executor.list_all ) ).each do |k,v|
  unless stored_tests.include?(k.to_s)
    test = Test.new
    test.name = k.to_s
    test.title = v["title"]
    test.author = v["author"]
    test.description = v["description"]
    test.methods = v["tests"]
    if v["resource_class"]
      test.resource_class = v["resource_class"].to_s
    end
    test.multiserver = v["multiserver"]
    test.save()
  end

end
