class App.DeleteAlertWindow extends App.PopupWondow
  template: new EJS url: 'templates/general/modal-delete-tpl.ejs'
  events:
    'click #delete-item': 'deleteRecord'
  initialize: ->
    @render()
  render: ->
    positon = @model.get('name')
    skills = @model.get('skills')

    @$el.html @template.render
      modalTitle: 'Warning'
      modalBody: '<p>Are you sure you want to delete record:</p>' +
      '<p>Position <strong>' + positon + '</strong> </p>' +
      '<p>Skills <strong>' + skills + '</strong></p>'
    @
  deleteRecord: ->
    @model.destroy
      error: ->
        $('#alert-message').html alertTpl.render
          alertMessage: "Server Error. Can't save your data. Try again later."
      success: ->
        $('#popup-window').modal 'hide'
        Log('Delet alert window was closed');
