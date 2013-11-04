class App.StaffColl extends Backbone.Collection
model: App.StaffModel
url: location.origin + '/staff-list'