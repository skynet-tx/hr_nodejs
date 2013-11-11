class App.User extends Backbone.Model
  urlRoot: location.origin + "/adm/user"
  defaults:
    'name': null
    'email': null
    'position': null
    'filial': null
    'role': 'manager'
    'password': null

  validate: (attrs) ->
    if (not attrs.name and not attrs.email)
      'Validation Error: Fill the fields'
