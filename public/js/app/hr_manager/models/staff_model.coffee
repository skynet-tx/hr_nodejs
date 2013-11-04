class App.StaffModel extends Backbone.Model
  urlRoot: location.origin + "/staff"
  defaults:
    name: 'Empty name'
    surname: null
    birthday: null
    city: null
    department: null
    position: null
    salary: null
    startDate: null
    date: new Date()

  validate: (attrs) ->
    'Validation Error: Fill the Name field' if (attrs.name is 'Empty name' or not attrs.name)