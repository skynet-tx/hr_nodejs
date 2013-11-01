class App.DeleteDepAlertWindow extends App.PopupWondow
  template: new EJS url: 'templates/general/modal-delete-tpl.ejs'
  events:
    'click #delete-item': 'deleteRecord'
  initialize: ->
    @render()
  render: ->
    name = @model.get('name')
    description = @model.get('description')

    @$el.html @template.render
      modalTitle: 'Warning'
      modalBody: '<p>Are you sure you want to delete record:</p>' +
      '<p>Department <strong>' + name + '</strong> </p>' +
      '<p>Description <strong>' + description + '</strong></p>'
    @

  deleteRecord: ->
    @model.destroy
      error: ->
        $('#alert-message').html alertTpl.render
          alertMessage: "Server Error. Can't save your data. Try again later."
      success: ->
        $('#popup-window').modal 'hide'
        Log('Delet alert window was closed');

