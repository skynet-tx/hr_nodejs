class App.DepPanel extends App.MainTemplate
  el: '.list-container'
  template: new EJS url: 'templates/general/list-conainer.ejs'
  events:
    'click #add-new': 'addNewDepartment'
    'click .btn-edit-record': 'editDepartment'
    'click .btn-delete-item': 'deleteItem'
    'submit': 'seachBy'

  initialize: ->
    Log 'departments'
    @collection.on('sync', @addDepartmentList, @)
    @collection.on('destroy', @reloadGrid, @)

  render: ->
    @$el.html @template.render({pageName: 'List of Departments'})
    seachFormTpl = new EJS url: 'templates/position_page/filter_area_tpl.ejs'
    $('.filter-form').prepend seachFormTpl.render()
    @

  reloadGrid: (gridData) ->
    $('#grid').html(' ')
    gridTpl = new EJS url: 'templates/department_page/department-grid.ejs'

    if gridData and gridData.hasOwnProperty('cid') is false
      App.gridData = gridData
    else
      @$el.find('#search-by').val()
      App.gridData = @collection.toJSON()

    $('#grid').html(gridTpl.render())
    @_removeDelBtn()
    Log 'Grid is reloaded..'


  addDepartmentList: (departments) ->
    Log('Show Grid')
    gridTpl = new EJS url: 'templates/department_page/department-grid.ejs'
    Log 'departments'

    App.gridData = departments.toJSON()
    $('#grid').html(gridTpl.render())
    @_removeDelBtn()
    @


  addNewDepartment: ->
    addWindow = new App.addNewDepartment
      collection: @collection
    $('#for-modal').html addWindow.el
    $('#popup-window').modal();
    Log 'Add new department window open';

  editDepartment: (eve)  ->
    Log "Edit button clicked"
    recordId = $(eve.target).attr 'data-id'
    department = @collection.findWhere id: parseInt(recordId, 10)

    addWindow = new App.addNewDepartment
      model: department
      collection: @collection
      isEdit: true

    $('#for-modal').html addWindow.el
    $('#popup-window').modal();
    Log 'Edit department window is open'

  deleteItem: (eve) ->
    recordId = $(eve.target).attr('data-id')
    model = @collection.findWhere id: parseInt(recordId, 10)
    deleteAlertWindow = new App.DeleteDepAlertWindow model: model
    $('#for-modal').html deleteAlertWindow.el
    $('#popup-window').modal()
    Log 'Delet alert window is open'

  seachBy:(eve) ->
    eve.preventDefault()

    formValue = @$el.find('.filter-form input').val().toLowerCase().trim()
    coll = @collection.toJSON()

    searchData = helper.filterSearch(coll, formValue)
    if searchData.length > 0
      @reloadGrid(searchData)
    else
      @reloadGrid()
