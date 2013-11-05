class App.LoginView extends App.MainTemplate
  el: 'body'
  template: new EJS url: 'templates/login/login_page.ejs'
  events:
    'submit': 'submitForm'

  render: ->
    @$el.html @template.render()

  submitForm: (eve) ->
    eve.preventDefault()
    formData = @_serializeForm()

    Log formData

  _serializeForm: ->
    formFields = @$el.find('.form-horizontal').serializeArray()
    formData = {}

    $.each formFields, (key, obj)  ->
      null if not obj['value']
      formData[obj['name']] = obj['value']

    formData['date'] = new Date()
    formData
