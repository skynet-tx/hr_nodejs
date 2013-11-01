class App.DepPanel extends App.MainTemplate
  el: '.list-container'
  template: new EJS url: 'templates/general/list-conainer.ejs'
  events:
    'click #add-new': 'addNewDepartment'



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