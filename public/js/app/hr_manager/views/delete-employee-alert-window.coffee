class App.DeleteEmplAlertWindow extends App.PopupWondow
  template: new EJS url: 'templates/general/modal-delete-tpl.ejs'
  events:
    'click #delete-item2': 'deleteRecord'
  initialize: ->
    @render()

  render: ->

    name = @model.get 'name'
    surname = @model.get 'surname'
    middle_name = @model.get 'middle_name'
    department = @model.get 'department'
    pasition = @model.get 'pasition'

    @$el.html @template.render
      modalTitle: 'Warning'
      modalBody: '<p>Are you sure you want to delete record:</p>' +
      '<p>Name:        <strong>' + name + '</strong> </p>' +
      '<p>Middle name: <strong>' + middle_name + '</strong> </p>' +
      '<p>Surname:     <strong>' + surname + '</strong> </p>' +
      '<p>Department:  <strong>' + department + '</strong> </p>' +
      '<p>Position:    <strong>' + pasition + '</strong></p>'
    @

  deleteRecord: ->
    @model.destroy
      error: ->
        $('#alert-message').html alertTpl.render
          alertMessage: "Server Error. Can't save your data. Try again later."
      success: ->
        $('#popup-window').modal 'hide'
        Log('Delet alert window was closed');
