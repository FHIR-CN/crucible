Crucible.Conformance = DS.Model.extend
  json: DS.attr()
  
  rest: (-> 
  	if @get('isMultiple')
  	  @collapseConformance().rest
  	else
  	  @first().rest
  ).property('json')

  identifier: (-> @first().identifier).property('identifier')
  version: (-> @first().version).property('version')
  name: (-> @first().name).property('name')
  publisher: (-> @first().publisher).property('publisher')
  telecom: (-> @first().telecom).property('telecom')
  description: (-> @first().description).property('description')
  status: (-> @first().status).property('status')
  experimental: (-> @first().experimental).property('experimental')
  date: (-> @first().date).property('date')
  software: (-> @first().software).property('software')
  implementation: (-> @first().implementation).property('implementation')
  fhirVersion: (-> @first().fhirVersion).property('fhirVersion')
  acceptUnknown: (-> @first().acceptUnknown).property('acceptUnknown')
  format: (-> @first().format).property('format')
  profile: (-> @first().profile).property('profile')
  messaging: (-> @first().messaging).property('messaging')
  document: (-> @first().document).property('document')

  identifier2: (-> @second()?.identifier).property('identifier')
  version2: (-> @second()?.version).property('version')
  name2: (-> @second()?.name).property('name')
  publisher2: (-> @second()?.publisher).property('publisher')
  telecom2: (-> @second()?.telecom).property('telecom')
  description2: (-> @second()?.description).property('description')
  status2: (-> @second()?.status).property('status')
  experimental2: (-> @second()?.experimental).property('experimental')
  date2: (-> @second()?.date).property('date')
  software2: (-> @second()?.software).property('software')
  implementation2: (-> @second()?.implementation).property('implementation')
  fhirVersion2: (-> @second()?.fhirVersion).property('fhirVersion')
  acceptUnknown2: (-> @second()?.acceptUnknown).property('acceptUnknown')
  format2: (-> @second()?.format).property('format')
  profile2: (-> @second()?.profile).property('profile')
  messaging2: (-> @second()?.messaging).property('messaging')
  document2: (-> @second()?.document).property('document')

  isMultiple: (-> @get('json').length > 1).property('json')
  
  first: ->
  	@get('json')[0]

  second: ->
  	@get('json')[1]

  collapseConformance: ->
  	collapsed = Ember.copy(@first(), true)
  	secondMap = {}
  	for rest in @second().rest
    	for resource in rest.resource
    		secondMap[resource.fhirType] = resource

  	for rest in collapsed.rest
    	for resource in rest.resource
    		secondResource = secondMap[resource.fhirType]
    		resource.operation.create = false

  	collapsed

  operations: (-> ['Read','VRead','Update','Delete','History-Instance','Validate','History-Type','Create','Search-Type']).property()



