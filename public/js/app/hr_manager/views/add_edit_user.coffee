class App.AddEditUser extends App.PopupWondow
  template: new EJS url: 'templates/general/modal-tpl.ejs'
  isEdit: false
  model: new App.User
  events:
    'click #form-save': 'eventSelection'

  initialize: (params) ->
    @isEdit = params.isEdit
    @render()

  render: ->
    formTpl = new EJS url: 'templates/users/user-form.ejs'

    if not @isEdit
      @$el.html @template.render
        modalTitle: 'Add New Manager or Admin'
        modalBody: formTpl.render()
    else
      positionName = @model.get 'name'
      @$el.html @template.render
        modalTitle: 'Edit record "<strong>' + positionName + '</strong>"'
        modalBody: formTpl.render()
      @_fiilFormValues()

    @

  eventSelection: (eve) ->
    if not @isEdit
      @saveNewPosition eve
    else
      @editRecord eve

  saveNewPosition: (eve) ->
    eve.preventDefault()

    alertTpl = new EJS url: 'templates/general/alert-danger-tpl.ejs'
    modelData =@_serializeForm();

    if modelData is false or not modelData
     return false;
    @model.set(modelData)
    @model.on 'invalid', (model, error) =>
      $('#alert-message').html(alertTpl.render alertMessage: error)


    @model.save @model.toJSON(),
      error: (model, xhr, options) ->
        errorMessage = "Server Error. Can't save your data. Try again later."
        if xhr.responseJSON and xhr.responseJSON.error and xhr.responseJSON.error.message
          errorMessage = xhr.responseJSON.error.message

        $('#alert-message').html alertTpl.render
          alertMessage: errorMessage

      success: =>
        $('#popup-window').modal 'hide'
        Log('Add new position window was closed')
        @collection.fetch({reset: true})

  _serializeForm: ->
    formFields = @$el.find('#add-edit-user-form').serializeArray()
    formData = {}
    alertTpl = new EJS url: 'templates/general/alert-danger-tpl.ejs'

    $.each formFields, (key, obj)  ->
      return if not obj['value']
      formData[obj['name']] = obj['value']

    if not formData['conf-password'] or formData['conf-password'] is not formData['password'] or formData['conf-password'].length < 4
      $('#alert-message').html(alertTpl.render alertMessage: 'Passwords do not match')
      return false
    else
      delete formData['conf-password']
      formData['date'] = new Date()
      formData
