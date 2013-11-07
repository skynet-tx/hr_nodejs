class App.PosColl extends Backbone.Collection
  model: App.PositionModel
  url: location.origin + '/positions-list'
