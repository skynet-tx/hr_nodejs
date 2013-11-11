class App.StaffPanel extends App.MainTemplate
  el: '.list-container'
  template: new EJS url: 'templates/general/list-conainer.ejs'
  events:
    'click #add-new': 'addNewEmployee'
    'click .btn-edit-record2': 'editEmployee'
    'click .btn-delete-item': 'deleteEmployee'
    'submit': 'seachBy'

  initialize: ->
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
    gridTpl = new EJS url: 'templates/staff_page/staff_grid.ejs'

    @$el.find('#search-by').val() # Clear search
    App.gridData = staff.toJSON()
    $('#grid').html(gridTpl.render())
    @

  addNewEmployee: ->
    selectModel = new App.AddEditEmployee
    selectModel.fetch()

    addWindow = new App.addNewStaff
      collection: @collection
      model: selectModel
    $('#for-modal').html addWindow.el
    $('#popup-window').modal();
    Log 'Add new staff window is open'


  editEmployee: (eve)  ->
    Log "Edit button clicked"
    recordId = $(eve.target).attr 'data-id'
    staffModel = @collection.findWhere id: parseInt(recordId, 10)

    addWindow = new App.addNewStaff
      model: staffModel
      collection: @collection
      isEdit: true

    $('#for-modal').html addWindow.el
    $('#popup-window').modal();
    Log 'Edit employee window is open'

  seachBy:(eve) ->
    eve.preventDefault()

    formValue = @$el.find('.filter-form input').val().toLowerCase().trim()
    staffList = @collection.toJSON()
    searchData = _.filter staffList, (obj) ->
      Log 'obj is here'
      Log obj
      keys = null
      _.each obj, (val, key) ->
        Log 'key is here'
        Log key
        if obj[key].toString().toLowerCase() == formValue
          keys = key
      return false if not obj[keys]
      obj[keys].toString().toLowerCase() == formValue

    if searchData.length > 0
      @reloadGrid(searchData)
    else
      @reloadGrid()