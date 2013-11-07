class App.addNewStaff extends App.PopupWondow
  template: new EJS url: 'templates/general/modal-tpl.ejs'
  staffModel: new App.StaffModel




  initialize: ->
    @model.on('sync', @showForm, @)


  render: (model) ->
    Log model

  showForm: (model) ->
    Log model.toJSON()
    editionParams = model.toJSON()
    formTpl = new EJS url: 'templates/staff_page/add_employee.ejs'
    Log 'The ADD window is opened'
    @$el.html @template.render
      modalTitle: 'Add New Employee'
      modalBody: formTpl.render
        position: editionParams.positions
#        @position.on("change:selection")
#          selection: ->()
#            this.$el.html(@.template(@.position.toJSON()))
        department: editionParams.departments






