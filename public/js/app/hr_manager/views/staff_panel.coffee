class App.StaffPanel extends App.MainTemplate
  el: '.list-container'
  template: new EJS url: 'templates/general/list-conainer.ejs'
  events:
    'click #add-new': 'addNewEmployee'
    'click .btn-edit-record2': 'editEmployee'
    'click .btn-delete-item2': 'deleteEmployee'
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
    selectModel = new App.AddEditEmployee()
    selectModel.fetch()
    recordId = $(eve.target).attr 'data-id'

    addWindow = new App.addNewStaff
      collection: @collection
      model: selectModel
      recordId: recordId
      isEdit: true

    $('#for-modal').html addWindow.el
    $('#popup-window').modal();
    Log 'Edit employee window is open'

  deleteEmployee: (eve) ->
    selectModel = new App.AddEditEmployee()
    selectModel.fetch()
    recordId = $(eve.target).attr 'data-id'
    selectModel = @collection.findWhere id: parseInt(recordId, 10)

    deleteAlertWindow = new App.DeleteEmplAlertWindow
      collection: @collection
      model: selectModel
      recordId: recordId
    $('#for-modal').html deleteAlertWindow.el
    $('#popup-window').modal()
    Log 'Delet alert window is open'

  seachBy:(eve) ->
    eve.preventDefault()

    formValue = @$el.find('.filter-form input').val().toLowerCase().trim()
    staffList = @collection.toJSON()

    searchData = _.filter staffList, (obj) ->
      keys = null
      _.each obj, (val, key) ->
        value = obj[key]+''
        if value.toLowerCase() == formValue
          keys = key
        return if not obj[key] or obj[key] == null
      value_keys = obj[keys]+''
      value_keys.toLowerCase() == formValue

    if searchData.length > 0
      @reloadGrid(searchData)
    else
      @reloadGrid()