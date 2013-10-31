class App.Dep.Panel extends App.MainTemplate
  el: '.list-container'
  template: new EJS url: 'templates/general/list-conainer.ejs'



  initialize: ->
  @collection.on('sync', @addDepartmentList, @)

  render: ->
    @$el.html @template.render({pageName: 'List of Departments'})
    @

    addDepartmentList: (departments) ->
    Log('Show Grid')
    gridTpl = new EJS url: 'templates/department_page/department-grid.ejs'

    App.gridData = departments.toJSON()
    $('#grid').html(gridTpl.render())
    @