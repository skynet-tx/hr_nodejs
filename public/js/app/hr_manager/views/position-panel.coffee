class App.PosPanel extends App.MainTemplate
  el: '.list-container'
  template: new EJS url: 'templates/general/list-conainer.ejs'
  events:
    'click #add-new': 'addNewPosition'
    'click .btn-edit-record': 'editPositioin'
    'click .btn-delete-item': 'deleteItem'

  initialize: ->
    @collection.on('reset', @addPositionsList, @)
    @collection.on('destroy', @reloadGrid, @)

  render: ->
    @$el.html @template.render({pageName: 'List of Positions'})
    @

  reloadGrid: ->
    $('#grid').html(' ')
    gridTpl = new EJS url: 'templates/position_page/positions-grid.ejs'
    Log @collection.toJSON()
    App.gridData = @collection.toJSON()
    $('#grid').html(gridTpl.render())
    Log 'Grid is reloaded..'


  addPositionsList: (positions) ->
    Log('Show Grid')
    gridTpl = new EJS url: 'templates/position_page/positions-grid.ejs'

    App.gridData = positions.toJSON()
    $('#grid').html(gridTpl.render())
    @

  addNewPosition: ->
    addWindow = new App.addNewPosition
      collection: @collection
    $('#for-modal').html addWindow.el
    $('#popup-window').modal();
    Log 'Add new position window is open'

  deleteItem: (eve) ->
    recordId = $(eve.target).attr('data-id')
    model = @collection.findWhere id: parseInt(recordId, 10)
    deleteAlertWindow = new App.DeleteAlertWindow model: model
    $('#for-modal').html deleteAlertWindow.el
    $('#popup-window').modal()
    Log 'Delet alert window is open'

  editPositioin: (eve)  ->
    recordId = $(eve.target).attr 'data-id'
    position = @collection.findWhere id: parseInt(recordId, 10)

    addWindow = new App.addNewPosition
      model: position
      collection: @collection
      isEdit: true

    $('#for-modal').html addWindow.el
    $('#popup-window').modal();
    Log 'Edit position window is open'
