# http://emberjs.com/guides/models/#toc_store
# http://emberjs.com/guides/models/pushing-records-into-the-store/

Crucible.ApplicationStore = DS.Store.extend({

})

# Override the default adapter with the `DS.ActiveModelAdapter` which
# is built to work nicely with the ActiveModel::Serializers gem.
Crucible.ApplicationAdapter = DS.ActiveModelAdapter.extend({
  namespace: "api"
})

# Crucible.ApplicationSerializer = DS.ActiveModelSerializer.extend
#   primaryKey: "_id"
