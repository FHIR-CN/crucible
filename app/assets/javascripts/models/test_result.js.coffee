Crucible.TestResult = DS.Model.extend Crucible.Tabbable,
  test: DS.belongsTo('test', {async: true})
  testRun: DS.belongsTo('testRun')
  results: DS.hasMany('result', {async: true})
  hasRun: DS.attr("boolean")
  passed: (-> !@get('results').any((el) -> el.get('failed'))).property('results')
  hasResults: (->
    @get('results.length') == @get('test.methods.length')
  ).property('results.@each')




Crucible.Result = DS.Model.extend Crucible.Tabbable, 
  code: DS.attr()
  # data: DS.attr()
  description: DS.attr()
  key: DS.attr()
  message: DS.attr()
  status: DS.attr()
  testMethod: DS.attr()
  links: DS.attr()#hasMany('link')
  requires: DS.attr()#hasMany('resource')
  validates: DS.attr()#hasMany('resource')
  # warnings: DS.hasMany('warning')
  failed: (-> (@get('status') == 'fail' or @get('status') == 'error')).property('status')
  passed: (->!@get('failed')).property('failed')



Crucible.Link = DS.Model.extend
  link: DS.attr('string')

Crucible.Resource = DS.Model.extend
  methods: DS.attr()
  resource: DS.attr('string')

Crucible.TestResultSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  primaryKey: '_id'
  attrs:
    results: {embeddded: 'always'}
  normalize: (type, hash, prop) ->
    delete hash.result # Even if populated I want to force an ajax call
    hash.links = {results: "result"}
    @_super(type,hash,prop)

Crucible.ResultSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    links: {embeddded:'always'}
    requires: {embeddded:'always'}
    validates: {embeddded:'always'}
