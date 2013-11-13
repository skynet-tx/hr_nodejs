class App.PosPanel extends App.MainTemplate
  el: '.list-container'
  template: new EJS url: 'templates/general/list-conainer.ejs'
  events:
    'click #add-new': 'addNewPosition'
    'click .btn-edit-record': 'editPosition'
    'click .btn-delete-item': 'deleteItem'
    'submit': 'seachBy'

  initialize: ->
    @collection.on('reset', @addPositionsList, @)
    @collection.on('destroy', @reloadGrid, @)

  render: ->
    @$el.html @template.render({pageName: 'List of Positions'})
    seachFormTpl = new EJS url: 'templates/position_page/filter_area_tpl.ejs'
    $('.filter-form').prepend seachFormTpl.render()
    @

  reloadGrid: (gridData) ->
    $('#grid').html(' ')
    gridTpl = new EJS url: 'templates/position_page/positions-grid.ejs'

    if gridData and gridData.hasOwnProperty('cid') is false
      App.gridData = gridData
    else
      @$el.find('#search-by').val() # Clear search
      App.gridData = @collection.toJSON()

    $('#grid').html(gridTpl.render())
    @_removeDelBtn()
    Log 'Grid is reloaded..'


  addPositionsList: (positions) ->
    Log('Show Grid')
    gridTpl = new EJS url: 'templates/position_page/positions-grid.ejs'
    @$el.find('#search-by').val() # Clear search
    App.gridData = positions.toJSON()
    $('#grid').html(gridTpl.render())
    @_removeDelBtn()
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

  editPosition: (eve)  ->
    recordId = $(eve.target).attr 'data-id'
    position = @collection.findWhere id: parseInt(recordId, 10)

    addWindow = new App.addNewPosition
      model: position
      collection: @collection
      isEdit: true

    $('#for-modal').html addWindow.el
    $('#popup-window').modal();
    Log 'Edit position window is open'

  seachBy:(eve) ->
    eve.preventDefault()

    formValue = @$el.find('.filter-form input').val().toLowerCase().trim()
    coll = @collection.toJSON()

    searchData = helper.filterSearch(coll, formValue)
    if searchData.length > 0
      @reloadGrid(searchData)
    else
      @reloadGrid()

