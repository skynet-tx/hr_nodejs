include ['js/app/core/views/mainTpl.js']

class App.StaffPage extends App.MainTemplate
  el: 'body'
  template: new EJS({url: 'templates/general/main-page-tpl.ejs'})

  events:
    'click .btn-logout': 'logout'

  initialize: (attrs) ->
    @positions = attrs.positions
    @model.on('sync', @setAuth, @)
    @render()

  render: ->
    @$el.html @template.render()

    return @

  setAuth: (model) ->
    App.isLoggin = model.get('isLoggin');
    if not App.isLoggin
      App.startApp.navigate('/login', {trigger: true, replace: true})

  logout: ->
    @model.set isLoggin: false
    @model.save @model.toJSON(),
      error: ->
        $('#alert-message').html alertTpl.render
          alertMessage: "Server Error. Can't save your data. Try again later."

      success: =>
        window.location.href = location.origin + '/#login'
