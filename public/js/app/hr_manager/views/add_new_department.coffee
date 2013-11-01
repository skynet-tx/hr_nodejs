class App.addNewDepartment extends App.PopupWondow

  template: new EJS url: 'templates/general/modal-tpl.ejs'
  isEdit: false
  model: new App.DepartmentModel

  events:
    'click #form-save': 'saveNewDepartment'

  initialize: ->
    @render()


  saveNewDepa: (eve) ->
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
        Log('Add new department window was closed')
        @collection.fetch({reset: true})

  _serializeForm: ->
    formFields = @$el.find('#add-department-form').serializeArray()
    formData = {}

    $.each formFields,(key, obj)  ->
      null if not obj['value']
      formData[obj['name']] = obj['value']

    formData['date'] = new Date()
    formData