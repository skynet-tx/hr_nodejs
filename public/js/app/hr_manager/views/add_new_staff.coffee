class App.addNewStaff extends App.PopupWondow
  template: new EJS url: 'templates/general/modal-tpl.ejs'
  model: new App.StaffModel

  initialize: () ->
    @render()

  render: ->
    formTpl = new EJS url: 'templates/staff_page/add_employee.ejs'
    Log 'The ADD window is opened'

    @$el.html @template.render
      modalTitle: 'Add New Employee'
      modalBody: formTpl.render()

