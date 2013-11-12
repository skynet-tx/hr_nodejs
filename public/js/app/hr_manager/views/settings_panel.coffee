class App.Settings extends App.MainTemplate
  el: '.list-container'
  template: new EJS url: 'templates/general/list-conainer.ejs'

  events:
    'click #add-new': 'addNewUser'
    'click .btn-edit-record': 'editUser'
    'click .btn-delete-item': 'deleteUser'

  initialize: ->
    @collection.on('reset', @addStaffList, @)
    @collection.on('destroy', @reloadGrid, @)

  render: ->
    @$el.html @template.render({pageName: 'Users list'})
    seachFormTpl = new EJS url: 'templates/position_page/filter_area_tpl.ejs'
    $('.filter-form').prepend seachFormTpl.render()
    @

  reloadGrid: (gridData) ->
    $('#grid').html(' ')
    gridTpl = new EJS url: 'templates/users/users-grid.ejs'

    if gridData and gridData.hasOwnProperty('cid') is false
      App.gridData = gridData
    else
      @$el.find('#search-by').val() # Clear search
      App.gridData = @collection.toJSON()

    $('#grid').html(gridTpl.render())
    Log 'Grid is reloaded..'
    @

  addStaffList: (usersData) ->
    gridTpl = new EJS url: 'templates/users/users-grid.ejs'

    @$el.find('#search-by').val() # Clear search
    App.gridData = usersData.toJSON()
    $('#grid').html(gridTpl.render())
    Log('Show Grid')
    @

  addNewUser: (eve) ->
    eve.preventDefault()
    addWindow = new App.AddEditUser
      collection: @collection

    $('#for-modal').html addWindow.el
    $('#popup-window').modal();
    Log 'Add new user window is open'

  deleteUser: (eve) ->
    eve.preventDefault()
    recordId = $(eve.target).attr('data-id')
    model = @collection.findWhere id: parseInt(recordId, 10)

    deleteWindow = new App.DeleteUserWindow model: model
    $('#for-modal').html deleteWindow.el
    $('#popup-window').modal()
    Log 'Delet alert window is open'

  editUser: (eve) ->
    eve.preventDefault()
    recordId = $(eve.target).attr 'data-id'
    user = @collection.findWhere id: parseInt(recordId, 10)

    editWindow = new App.AddEditUser
      model: user
      collection: @collection
      isEdit: true

    $('#for-modal').html editWindow.el
    $('#popup-window').modal();
    Log 'Edit User window is open'
