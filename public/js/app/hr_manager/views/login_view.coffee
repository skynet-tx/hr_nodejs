class App.LoginView extends App.MainTemplate
  el: 'body'
  template: new EJS url: 'templates/login/login_page.ejs'
  events:
    'submit': 'submitForm'

  render: ->
    @$el.html @template.render()

  submitForm: (eve) ->
    eve.preventDefault()

    Log 'tap'
