class App.addNewPosition extends App.PopupWondow
  template: new EJS url: 'templates/general/modal-tpl.ejs'
  isEdit: false
  model: new App.PositionModel

  events:
    'click #form-save': 'saveNewPosition'

  initialize: ->
    @render()
  render: ->
    formTpl = new EJS url: 'templates/position_page/add-form.ejs'

    @$el.html @template.render
      modalTitle: 'Add New Position'
      modalBody: formTpl.render()
      # TODO: make Edit mod of App(add btn name, fill the empty fields and ets

    @
  saveNewPosition: (eve) ->
    eve.preventDefault()
    alertTpl = new EJS url: 'templates/general/alert-danger-tpl.ejs'
    @model.set(@_serializeForm())

    @model.on 'invalid', (model, error) =>
      $('#alert-message').html(alertTpl.render alertMessage: error)

    @model.save  @model.toJSON(),
      error: ->
        $('#alert-message').html alertTpl.render
          alertMessage: "Server Error. Can't save your data. Try again later."

      success: =>
        $('#popup-window').modal 'hide'
        Log('Add new position window was closed')
        @collection.fetch({reset: true})

  _serializeForm: ->
    formFields = @$el.find('#add-position-form').serializeArray()
    formData = {}

    $.each formFields,(key, obj)  ->
      null if not obj['value']
      formData[obj['name']] = obj['value']

    formData['date'] = new Date()
    formData
