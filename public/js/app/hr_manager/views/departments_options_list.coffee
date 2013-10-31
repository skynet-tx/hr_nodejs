class App.DepartmentsOptionsList extends App.MainTemplate
  tagName: 'select',
  className: 'form-control'
  attributes:
    id: 'inputDepartments'

  initialize: ->
    @collection.on('sync', @render, @)

  render: (list) ->
    data = list.toJSON()
    liTpl = new EJS url: 'templates/department_page/option_li_list.ejs'
    el = @$el

    _.each data, (obj, key) ->
      el.append liTpl.render
        id: obj.id
        name: obj.name
