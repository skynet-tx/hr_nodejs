class App.LoginModel extends Backbone.Model
  urlRoot: location.origin + '/login-page'
  defaults:
    'email': null
    'password': null
    'date': new Date()

  validate: (attrs) ->
    if not attrs.email or not attrs.password
      'Validation Error: Fill the Email or Password'
