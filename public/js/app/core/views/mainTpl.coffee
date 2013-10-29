class App.MainTemplate extends Backbone.View
  initialize: ->
    @render()
  close: ->
    helper.log 'Removed all events...'
    @stopListening()
    $(@.el).empty();
