class App.LoginModel extends Backbone.Model
  urlRoot: location.origin + '/login-page'
  defaults:
    'email': null
    'password': null
    'isRemember': false

  validate: (attrs) ->
    if not attrs.email and not attrs.password
      'Validation Error: Fill the Email or Password'
