class App.StaffColl extends Backbone.Collection
  url: location.origin + '/staff-list'
  model: App.StaffModel
