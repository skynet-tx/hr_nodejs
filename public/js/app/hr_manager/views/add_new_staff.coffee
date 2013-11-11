class App.addNewStaff extends App.PopupWondow

  template: new EJS url: 'templates/general/modal-tpl.ejs'
  isEdit: false
  staffModel: new App.StaffModel()

  events:
    'click #form-save': 'eventSelection'
    "change #inputPosition": "fillSkills"


  initialize: (params) ->
    @isEdit = params.isEdit
    @model.on('sync', @showForm, @)


  render: (model) ->
    Log model

  showForm: (model) ->
    Log model.toJSON()
    @editionParams = model.toJSON()
    formTpl = new EJS url: 'templates/staff_page/add_employee.ejs'
#    listDep = @_getSelectDept()
#    listPos = @_getSelectPost()

    if not @isEdit
      Log 'The ADD window is opened'
      @$el.html @template.render
        modalTitle: 'Add New Employee'
        modalBody: formTpl.render
          position: @editionParams.positions
          department: @editionParams.departments

    else
      employeeSurname = @staffModel.get 'surname'
      @$el.html @template.render
        modalTitle: 'Edit record "<strong>' + employeeSurname + '</strong>"'
        modalBody: formTpl.render()
#      @$el.find('.dep-list').html(list)
          position: @editionParams.positions
          department: @editionParams.departments
      @_fiilFormValues()
    @

  eventSelection: (eve) ->
    if not @isEdit
      @saveNewEmployee eve
    else
      @editRecord eve

  fillSkills: (eve) ->
    positionId = $(eve.target).val()
    position = _.find @editionParams.positions, (Obj) ->
      parseInt(positionId, 10) is parseInt(Obj.positionId, 10)

    Log position
    @$el.find('#inputSkill').val helper.ucfirst position.positionsSkill

  saveNewEmployee: (eve) ->
    eve.preventDefault()
    alertTpl = new EJS url: 'templates/general/alert-danger-tpl.ejs'
    @staffModel.set(@_serializeForm())
    @staffModel.on 'invalid', (model, error) =>
      $('#alert-message').html(alertTpl.render alertMessage: error)
    @staffModel.save @staffModel.toJSON(),
      error: ->
        $('#alert-message').html alertTpl.render
          alertMessage: "Server Error. Can't save your data. Try again later."

      success: =>
        $('#popup-window').modal 'hide'
        Log('Add new employee window was closed')
        @collection.fetch({reset: true})

  _serializeForm: ->
    formFields = @$el.find('#add-employee-form').serializeArray()
    formData = {}

    $.each formFields,(key, obj)  ->
      null if not obj['value']
      formData[obj['name']] = obj['value']

    formData['date'] = new Date()
    formData



  editRecord: (eve) ->
    eve.preventDefault()
    alertTpl = new EJS url: 'templates/general/alert-danger-tpl.ejs'
    @staffModel.set(@_serializeForm())
    @staffModel.save @staffModel.toJSON(),
      error: ->
        $('#alert-message').html alertTpl.render
          alertMessage: "Server Error. Can't save your data. Try again later."

      success: =>
        $('#popup-window').modal 'hide'
        Log('Add new department window was closed')
        @collection.fetch({reset: true})

  _fiilFormValues: ->
    form = @$el.find '#add-employee-form'
    form.find('#inputName').val @staffModel.get 'name'
    form.find('#inputMiddlename').val @staffModel.get 'middle_name'
    form.find('#inputSurname').val @staffModel.get 'surname'
    form.find('#inputBirthday').val @staffModel.get 'birthday'
    form.find('#inputCity').val @staffModel.get 'city'
    form.find('#inputSalary').val @staffModel.get 'salary'
#    form.find('#inputDepartment').val @staffModel.get 'departments'
#    form.find('#inputPosition').val @staffModel.get 'positions'



