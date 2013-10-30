class App.addNewPosition extends App.PopupWondow
  template: new EJS url: 'templates/general/modal-tpl.ejs'

  events:
    'click #form-save': 'saveNewPosition'

  initialize: ->
    @render()
  render: ->
    formTpl = new EJS url: 'templates/position_page/add-form.ejs'

    @$el.html @template.render
      modalTitle: 'Add New Position'
      modalBody: formTpl.render()
    @
  saveNewPosition: ->
    positonModel = new App.PositionModel
    alertTpl = new EJS url: 'templates/general/alert-danger-tpl.ejs'
    positonModel.set(@_serializeForm())

    positonModel.on 'invalid', (model, error) =>
      $('#alert-message').html(alertTpl.render alertMessage: error)

    positonModel.save positonModel.toJSON(),
      error: ->
        $('#alert-message').html alertTpl.render
          alertMessage: "Server Error. Can't save your data. Try again later."

      success: ->
        $('#popup-window').modal 'hide'
        positions = new App.PosColl()
        positions.fetch reset: true
        new App.PosPanel collection: positions
#        @stopListening()
#        @.remove();


  _serializeForm: ->
    formFields = @$el.find('#add-position-form').serializeArray()
    formData = {}

    $.each formFields,(key, obj)  ->
      null if not obj['value']
      formData[obj['name']] = obj['value']

    formData['date'] = new Date()
    formData
