class App.Users extends Backbone.Collection
  url: location.origin + '/adm/users-list'
  model: App.User