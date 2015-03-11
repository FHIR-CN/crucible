
Crucible.Tabbable = Em.Mixin.create
  data_selector: (-> "#{@constructor.toString().replace(".", "_")}#{@get('id')}").property('id')
  selector: (-> "\##{@get('data_selector')}").property('data_selector')
