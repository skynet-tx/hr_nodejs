class App.addNewDepartment extends App.PopupWondow

  template: new EJS url: 'templates/general/modal-tpl.ejs'
  isEdit: false
  model: new App.DepartmentModel

  events:
    'click #form-save': 'eventSelection'

  initialize: (params) ->
    @isEdit = params.isEdit
    @render()

  render: ->
    formTpl = new EJS url: 'templates/position_page/add-dep-form.ejs'

    if not @isEdit
      @$el.html @template.render
        modalTitle: 'Add New Department'
        modalBody: formTpl.render()

    else
      departmentName = @model.get 'name'
      @$el.html @template.render
        modalTitle: 'Edit record "<strong>' + departmentName + '</strong>"'
        modalBody: formTpl.render()

    @

  eventSelection: (eve) ->
    if not @isEdit
      @saveNewDepartment eve
    else
      @editRecord eve

  saveNewDepartment: (eve) ->
    eve.preventDefault()
    alertTpl = new EJS url: 'templates/general/alert-danger-tpl.ejs'
    @model.set(@_serializeForm())
    @model.on 'invalid', (model, error) =>
      $('#alert-message').html(alertTpl.render alertMessage: error)
    @model.save  @model.toJSON(),
      error: ->
        $('#alert-message').html alertTpl.render
          alertMessage: "Server Error. Can't save your data. Try again later."

      success: =>
        $('#popup-window').modal 'hide'
        Log('Add new department window was closed')
        @collection.fetch({reset: true})

  _serializeForm: ->
    formFields = @$el.find('#add-department-form').serializeArray()
    formData = {}

    $.each formFields,(key, obj)  ->
      null if not obj['value']
      formData[obj['name']] = obj['value']

    formData['date'] = new Date()
    formData