class App.StaffModel extends Backbone.Model
  urlRoot: location.origin + "/employee"
  defaults:
    id: null
    name: null
    surname: null
    middle_name: null
    birthday: null
