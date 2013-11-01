class App.DepPanel extends App.MainTemplate
  el: '.list-container'
  template: new EJS url: 'templates/general/list-conainer.ejs'
  events:
    'click #add-new': 'addNewDepartment'
    'click .btn-edit-record': 'editPositioin'
    'click .btn-delete-item': 'deleteItem'



  initialize: ->
    Log 'departments'
    @collection.on('sync', @addDepartmentList, @)
    @collection.on('destroy', @reloadGrid, @)

  render: ->
    Log 'here'
    @$el.html @template.render({pageName: 'List of Departments'})
    @

  reloadGrid: ->
    $('#grid').html(' ')
    gridTpl = new EJS url: 'templates/department_page/department-grid.ejs'

    App.gridData = @collection.toJSON()
    $('#grid').html(gridTpl.render())
    Log 'Grid is reloaded..'



  addDepartmentList: (departments) ->
    Log('Show Grid')
    gridTpl = new EJS url: 'templates/department_page/department-grid.ejs'
    Log 'departments'

    App.gridData = departments.toJSON()
    $('#grid').html(gridTpl.render())
    @


  addNewDepartment: ->
    addWindow = new App.addNewDepartment
      collection: @collection
    $('#for-modal').html addWindow.el
    $('#popup-window').modal();
    Log 'Add new department window open';

  editPositioin: (eve)  ->
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
