include ['js/app/core/views/mainTpl.js']

class App.StaffPage extends App.MainTemplate
  el: 'body'
  template: new EJS url: 'templates/general/main-page-tpl.ejs'

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
    @isLoggin = model.get('isLoggin')

    if not @isLoggin
      App.startApp.navigate '/login', trigger: true, replace: true
    @_setAuthorizedAs model.get 'authorizedAs'
    @_setSettingsLink model.get('role')

  logout: ->
    @model.set isLoggin: false
    @model.save @model.toJSON(),
      error: ->
        $('#alert-message').html alertTpl.render
          alertMessage: "Server Error. Can't save your data. Try again later."

      success: =>
        window.location.href = location.origin + '/#login'

  _setAuthorizedAs: (email) ->
    @$el.find('.authorizedAs').text(email);

  _setSettingsLink: (role) ->
    linkTpl = '<a href="/#adm/settings" class="btn btn-link glyphicon glyphicon-wrench btn-settings"></a>'
    if role is 'admin'
      @$el.find('.page-settings').append linkTpl
      App.checkIsAdmin = true;
