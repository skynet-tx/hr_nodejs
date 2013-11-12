class App.StaffModel extends Backbone.Model
  urlRoot: location.origin + "/employee"
  defaults:
    id: null
    name: null
    surname: null
    middle_name: null
    birthday: null
    city: null
    department_id: null
    position_id: null
    salary: null
    startDate: null
    date: new Date()

#  validate: (attrs) ->
#    'Validation Error: Fill the Name field' if (attrs.name is 'Empty name' or not attrs.name)
