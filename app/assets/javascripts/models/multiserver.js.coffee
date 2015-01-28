Crucible.Multiserver = DS.Model.extend
  url1: DS.attr("string")
  conformance1: DS.attr()
  url2: DS.attr("string")
  conformance2: DS.attr()
  conformance: (->
  	@store.createRecord('conformance',json: [this.get('conformance1'), this.get('conformance2')])).property('conformance1', 'conformance2')
  updateConformanceResults: (->
    return unless @get('tests')?
    tests = @get('tests').filter((t) -> _(t.get('summary')).keys().length > 0).getEach('summary')
    conf1 = @get('conformance1')
    conf2 = @get('conformance2')
    if conf1?
      @set('conformance1', null) #FIXME Change model directly to trigger rerender
      for summary in tests
        for resource, results of summary
          if resource == 'system'
            conf1.rest[0].results = _(conf1.rest[0].results).extend(results)
          else
            _(conf1.rest[0].resource).findWhere( fhirType: resource ).results = _(_(conf1.rest[0].resource).findWhere( fhirType: resource ).results).extend(results)
      @set('conformance1', conf1)
    if conf2?
      @set('conformance2', null) #FIXME Change model directly to trigger rerender
      for summary in tests
        for resource, results of summary
          if resource == 'system'
            conf2.rest[0].results = _(conf2.rest[0].results).extend(results)
          else
            _(conf2.rest[0].resource).findWhere( fhirType: resource ).results = _(_(conf2.rest[0].resource).findWhere( fhirType: resource ).results).extend(results)
      @set('conformance2', conf2)
  ).observes('tests.@each.results') # Replace with 'isComplete' for more performant rendering
