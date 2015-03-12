Crucible.Conformance = DS.Model.extend
  acceptUnknown: DS.attr("boolean")
  contained: DS.attr()
  date: DS.attr("date")
  description: DS.attr("string")
  experimental: DS.attr("boolean")
  fhirVersion: DS.attr("string")
  format: DS.attr()
  identifier: DS.attr("string")
  implicitRules: DS.attr()
  language: DS.attr()
  messaging: DS.attr()
  modifier_id: DS.attr()
  name: DS.attr("string")
  profile: DS.attr()
  publisher: DS.attr("string")
  rest: DS.hasMany("mode")
  status: DS.attr("string")
  telecom: DS.attr()
  text: DS.attr()
  version: DS.attr()
  versionNum: DS.attr("string")
  xmlId: DS.attr("string")



  # rest: (->
  #   @collapseConformance().rest
  # ).property('json')
  #
  # identifier: (-> @first().identifier).property('identifier')
  # version: (-> @first().version).property('version')
  # name: (-> @first().name).property('name')
  # publisher: (-> @first().publisher).property('publisher')
  # telecom: (-> @first().telecom).property('telecom')
  # description: (-> @first().description).property('description')
  # status: (-> @first().status).property('status')
  # experimental: (-> @first().experimental).property('experimental')
  # date: (-> @first().date).property('date')
  # software: (-> @first().software).property('software')
  # implementation: (-> @first().implementation).property('implementation')
  # fhirVersion: (-> @first().fhirVersion).property('fhirVersion')
  # acceptUnknown: (-> @first().acceptUnknown).property('acceptUnknown')
  # format: (-> @first().format).property('format')
  # profile: (-> @first().profile).property('profile')
  # messaging: (-> @first().messaging).property('messaging')
  # document: (-> @first().document).property('document')
  #
  # identifier2: (-> @second()?.identifier).property('identifier')
  # version2: (-> @second()?.version).property('version')
  # name2: (-> @second()?.name).property('name')
  # publisher2: (-> @second()?.publisher).property('publisher')
  # telecom2: (-> @second()?.telecom).property('telecom')
  # description2: (-> @second()?.description).property('description')
  # status2: (-> @second()?.status).property('status')
  # experimental2: (-> @second()?.experimental).property('experimental')
  # date2: (-> @second()?.date).property('date')
  # software2: (-> @second()?.software).property('software')
  # implementation2: (-> @second()?.implementation).property('implementation')
  # fhirVersion2: (-> @second()?.fhirVersion).property('fhirVersion')
  # acceptUnknown2: (-> @second()?.acceptUnknown).property('acceptUnknown')
  # format2: (-> @second()?.format).property('format')
  # profile2: (-> @second()?.profile).property('profile')
  # messaging2: (-> @second()?.messaging).property('messaging')
  # document2: (-> @second()?.document).property('document')
  #
  # isMultiple: (-> @get('json').length > 1).property('json')
  #
  # first: ->
  # 	@get('json')[0]
  #
  # second: ->
  # 	@get('json')[1]
  #
  # collapseConformance: ->
  #   operationsList = ['read', 'vread', 'update', 'delete', 'history-instance', 'validate', 'history-type', 'create', 'search-type']
  #
  #   #multi server
  #   if @get('isMultiple')
  #     collapsed = Ember.copy(@first(), true)
  #     secondMap = {}
  #     secondExclusive = {}
  #     temp = []
  #
  #     # populating list of resources of second server
  #     for rest in @second().rest
  #       for resource in rest.resource
  #         secondMap[resource.fhirType] = resource
  #         temp.push resource.fhirType
  #
  #     for rest in collapsed.rest
  #       for resource in rest.resource
  #         if resource.fhirType in temp
  #           temp.splice(temp.indexOf(resource.fhirType), 1)
  #         secondResource = secondMap[resource.fhirType]
  #         if secondResource
  #           for op in operationsList
  #             if resource.operation[op]
  #               if secondResource.operation[op]
  #                 resource.operation[op] = 'test-filled'
  #               else
  #                 resource.operation[op] = 'left-circle'
  #             else if secondResource.operation[op]
  #               resource.operation[op] = 'right-circle'
  #             else
  #               resource.operation[op] ='test-empty'
  #         else
  #           for op in operationsList
  #             if resource.operation[op]
  #               resource.operation[op] = 'left-circle'
  #             else
  #               resource.operation[op] ='test-empty'
  #
  #       for resourceName in temp
  #         resource = secondMap[resourceName]
  #         for op in operationsList
  #           if resource.operation[op]
  #             resource.operation[op] = 'right-circle'
  #           else
  #             resource.operation[op] ='test-empty'
  #         collapsed.rest[0].resource.push resource
  #
  #
  #
  #   #one server
  #   else
  #     collapsed = Ember.copy(@first(), true)
  #     for rest in collapsed.rest
  #       for resource in rest.resource
  #         for op in operationsList
  #           if resource.operation[op]
  #             resource.operation[op] = 'test-filled'
  #           else
  #             resource.operation[op] ='test-empty'
  #   collapsed

  operations: (-> ['Read','VRead','Update','Delete','History-Instance','Validate','History-Type','Create','Search-Type']).property()

Crucible.ConformanceSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  primaryKey: '_id'
  attrs:
    rest: {embedded:'always'}
  normalize: (type, hash, prop) ->
    hash.id = Em.generateGuid(hash, "conformance")
    @_super(type, hash, prop)


Crucible.Mode = DS.Model.extend
  documentation: DS.attr()
  interaction: DS.attr()
  mode: DS.attr()
  operation: DS.attr()
  xmlId: DS.attr()
  results: DS.attr()
  resource: DS.hasMany('fhirType')


Crucible.ModeSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  primaryKey: '_id'
  attrs:
    resource: {embedded:'always'}

Crucible.FhirType = DS.Model.extend
  fhirType: DS.attr()
  interaction: DS.attr()
  profile: DS.attr()
  readHistory: DS.attr()
  searchInclude: DS.attr()
  searchParam: DS.attr()
  updateCreate: DS.attr()
  versioning: DS.attr()
  xmlId: DS.attr()
  operation: DS.attr()
  results: DS.attr()
  read: (-> @get('operation')['read']||false).property('operation')
  vread: (-> @get('operation')['vread']||false).property('operation')
  update: (-> @get('operation')['update']||false).property('operation')
  delete: (-> @get('operation')['delete']||false).property('operation')
  historyInstance: (-> @get('operation')['history-instance']||false).property('operation')
  validate: (-> @get('operation')['validate']||false).property('operation')
  historyType: (-> @get('operation')['history-type']||false).property('operation')
  create: (-> @get('operation')['create']||false).property('operation')
  searchType: (-> @get('operation')['search-type']||false).property('operation')


Crucible.FhirTypeSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  primaryKey: '_id'
