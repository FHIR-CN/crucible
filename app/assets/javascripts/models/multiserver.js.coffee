Crucible.Multiserver = DS.Model.extend
  url1: DS.attr("string")
  conformance1: DS.attr()
  url2: DS.attr("string")
  conformance2: DS.attr()
  conformance: (->
  	@store.createRecord('conformance',json: [this.get('conformance1'), this.get('conformance2')])).property('conformance1', 'conformance2')
