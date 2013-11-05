class App.StaffPanel extends App.MainTemplate
  el: '.list-container'
  template: new EJS url: 'templates/general/list-conainer.ejs'
  events:
    'click #add-new': 'addNewEmployee'
    'click .btn-edit-record': 'editEmployee'
    'click .btn-delete-item': 'deleteEmployee'
    'submit': 'seachBy'

  initialize: ->
    Log 'staff-list'
    @collection.on('reset', @addStaffList, @)
    @collection.on('destroy', @reloadGrid, @)

  render: ->
    @$el.html @template.render({pageName: 'Staff list'})
    seachFormTpl = new EJS url: 'templates/position_page/filter_area_tpl.ejs'
    $('.filter-form').prepend seachFormTpl.render()
    @

  reloadGrid: (gridData) ->
    $('#grid').html(' ')
    gridTpl = new EJS url: 'templates/staff_page/staff_grid.ejs'
    if gridData
      App.gridData = gridData
    else
      @$el.find('#search-by').val() # Clear search
      App.gridData = @collection.toJSON()

    $('#grid').html(gridTpl.render())
    Log 'Grid is reloaded..'

  addStaffList: (staff) ->
    Log('Show Grid')
    gridTpl = new EJS url: 'templates/staff_page/staff_grid.ejs'
    Log('Grid')
    Log staff.toJSON()

    @$el.find('#search-by').val() # Clear search
    App.gridData = staff.toJSON()
    $('#grid').html(gridTpl.render())
    @