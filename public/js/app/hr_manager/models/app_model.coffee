class App.ApplicationModel extends Backbone.Model
  urlRoot: location.origin + "/check-app"
  defaults:
    isLoggin: null
