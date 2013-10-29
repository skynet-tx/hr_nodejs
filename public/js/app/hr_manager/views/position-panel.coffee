class App.PosPanel extends App.MainTemplate
  el: '.list-container'
  template: new EJS({url: 'templates/general/list-conainer.ejs'})
  events:
    'click #add-new': 'addNewPosition'
    'click #form-save': 'saveNewPosition'
    'click .btn-edit-record': 'editPosition'
  initialize: ->
    @render()


  render: ->
    @$el.html @template.render({pageName: 'List of Positions'})

    @
