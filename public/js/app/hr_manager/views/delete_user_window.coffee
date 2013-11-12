class App.DeleteUserWindow extends App.PopupWondow
  template: new EJS url: 'templates/general/modal-delete-tpl.ejs'
  events:
    'click #delete-item': 'deleteRecord'
  initialize: ->
    @render()
  render: ->
    name = @model.get('name')
    email = @model.get('email')
    role = @model.get('role')
    position = @model.get('position')

    @$el.html @template.render
      modalTitle: 'Warning'
      modalBody: '<p>Are you sure you want to delete <u>' + role + '</u>:</p>' +
      '<p>User: <strong>' + name + '</strong> </p>' +
      '<p>Email: <strong>' + email + '</strong></p>' +
      '<p>Position is - <strong>' + position + '</strong></p>'
    @
  deleteRecord: ->
    @model.destroy
      error: ->
        $('#alert-message').html alertTpl.render
          alertMessage: "Server Error. Can't save your data. Try again later."
      success: ->
        $('#popup-window').modal 'hide'
        Log('Delet alert window was closed');
