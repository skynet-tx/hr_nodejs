class App.MainTemplate extends Backbone.View
  initialize: ->
    @render()

  close: ->
    helper.log 'Removed all events...'
    @stopListening()
    @undelegateEvents()
    $(@.el).empty();

  isAdmin: ->
    Cookie.get('role') is 'admin'

  _removeDelBtn: ->
    if not @isAdmin()
      @$el.find('.btn-delete-item').remove()
