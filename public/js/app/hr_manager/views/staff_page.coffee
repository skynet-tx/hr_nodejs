include ['js/app/core/views/mainTpl.js']

class App.StaffPage extends App.MainTemplate
  el: 'body'
  template: new EJS({url: 'templates/general/main-page-tpl.ejs'})
  render: ->
    @$el.html @template.render()
    return @
