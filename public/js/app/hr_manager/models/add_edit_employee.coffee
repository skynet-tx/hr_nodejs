class App.AddEditEmployee extends Backbone.Model
  urlRoot: location.origin + "/add-edit-employee"
  defaults:
    positions: [],
    departments: []
