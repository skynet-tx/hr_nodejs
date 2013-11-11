class App.Settings extends App.MainTemplate
  el: '.list-container'
  template: new EJS url: 'templates/general/list-conainer.ejs'

  events:
    'click #add-new': 'addNewUser'

  initialize: ->
    Log 'staff-list'
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
    if gridData
      App.gridData = gridData
    else
      @$el.find('#search-by').val() # Clear search
      App.gridData = @collection.toJSON()

    $('#grid').html(gridTpl.render())
    Log 'Grid is reloaded..'
    @

  addStaffList: (usersData) ->
    gridTpl = new EJS url: 'templates/users/users-grid.ejs'
    Log('Grid')

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
