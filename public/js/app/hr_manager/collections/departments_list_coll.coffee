class App.DepartmentsListColl extends Backbone.Collection
  model: App.DepartmentModel
  url: location.origin + '/departments-list'
