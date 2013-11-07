class App.LoginView extends App.MainTemplate
  el: 'body'
  template: new EJS url: 'templates/login/login_page.ejs'
  events:
    'submit': 'submitForm'

  render: ->
    @$el.html @template.render()
    setTimeout ->
      if App.isLoggin
        window.location.href = location.origin + '/'
    , 300
    @

  submitForm: (eve) ->
    eve.preventDefault()
    formData = @_serializeForm($(eve.target))
    @_onLogin(formData)

  _serializeForm: (formFields) ->
    formData = {}

    $.each formFields.serializeArray(), (key, obj)  ->
      null if not obj['value']
      formData[obj['name']] = obj['value']

    formData['date'] = new Date()
    formData

  _onLogin: (formData) ->
    alertTpl = new EJS url: 'templates/general/alert-danger-tpl.ejs'

    @model.set(formData)
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
        Log('Login success!')
        window.location.href = location.origin + '/'
