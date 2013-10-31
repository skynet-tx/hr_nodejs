class App.Dep.Panel extends App.MainTemplate
  el: '.list-container'
  template: new EJS url: 'templates/general/list-conainer.ejs'

  render: ->
    @$el.html @template.render({pageName: 'List of Departments'})
    @