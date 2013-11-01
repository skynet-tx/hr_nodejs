class App.DepartmentModel extends Backbone.Model
  urlRoot: location.origin + "/department"
  defaults:
    id: null
    name: null
    description: null
    date: new Date()

  validate: (attrs) ->
    'Validation Error: Fill the Name field' if (attrs.name is null or not attrs.name)
