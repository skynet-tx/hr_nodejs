class App.PosPanel extends App.MainTemplate
  el: '.list-container'
  template: new EJS url: 'templates/general/list-conainer.ejs'
  events:
    'click #add-new': 'addNewPosition'
    'click .btn-edit-record': 'editPosition'
    'click .btn-delete-item': 'deleteItem'

  initialize: ->
    @collection.on('sync', @addPositionsList, @)
    @collection.on('destroy', @reloadGrid, @)

  render: ->
    @$el.html @template.render({pageName: 'List of Positions'})
    @

  reloadGrid: ->
    $('#grid').html(' ')
    gridTpl = new EJS url: 'templates/position_page/positions-grid.ejs'
    App.gridData = @collection.toJSON()
    $('#grid').html(gridTpl.render())


  addPositionsList: (positions) ->
    Log('Show Grid')
    gridTpl = new EJS url: 'templates/position_page/positions-grid.ejs'

    App.gridData = positions.toJSON()
    $('#grid').html(gridTpl.render())
    @

  addNewPosition: ->
    addWindow = new App.addNewPosition({collection: @collection})
    $('#for-modal').html(addWindow.el)
    $('#popup-window').modal();
    Log('Add new position window open');

  deleteItem: (eve) ->
    recordId = $(eve.target).attr('data-id')
    model = @collection.findWhere({id: parseInt(recordId, 10)});
    deleteAlertWindow = new App.DeleteAlertWindow model: model
    $('#for-modal').html(deleteAlertWindow.el)
    $('#popup-window').modal();
    Log('Delet alert window open');
