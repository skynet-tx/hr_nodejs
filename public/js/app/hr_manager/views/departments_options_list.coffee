class App.DepartmentsOptionsList extends App.MainTemplate
  tagName: 'li',

  initialize: ->
    @collection.on('sync', @render, @)

  render: (list) ->
    data = list.toJSON()
    liTpl = new EJS url: 'templates/department_page/option_li_list.ejs'
    liListArray = []

    _.each data, (obj, key) ->
      liListArray.push liTpl.render
        id: obj.id
        name: obj.name


