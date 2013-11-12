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
    @recordId = params.recordId

  render: (model) ->
    Log model

  showForm: (model) ->
    Log model.toJSON()
    @editionParams = model.toJSON()
    formTpl = new EJS url: 'templates/staff_page/add_employee.ejs'

    Log @editionParams

    if not @isEdit
      Log 'The ADD window is opened'
      @$el.html @template.render
        modalTitle: 'Add New Employee'
        modalBody: formTpl.render
          position: @editionParams.positions
          department: @editionParams.departments

    else
      @model = @collection.findWhere id: parseInt(@recordId, 10)
      employeeSurname = @model.get 'surname'
      @$el.html @template.render
        modalTitle: 'Edit record "<strong>' + employeeSurname + '</strong>"'
        modalBody: formTpl.render
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
    @model.set(@_serializeForm())
    @model.save @model.toJSON(),
      error: ->
        $('#alert-message').html alertTpl.render
          alertMessage: "Server Error. Can't save your data. Try again later."

      success: =>
        $('#popup-window').modal 'hide'
        Log('Add new department window was closed')
        @collection.fetch({reset: true})

  _fiilFormValues: ->

    @model = @collection.findWhere id: parseInt(@recordId, 10)
    Log 'model here'
    Log @model

    form = @$el.find '#add-employee-form'
    form.find('#inputName').val @model.get 'name'
    form.find('#inputMiddlename').val @model.get 'middle_name'
    form.find('#inputSurname').val @model.get 'surname'
    form.find('#inputBirthday').val @model.get 'birthday'
    form.find('#inputCity').val @model.get 'city'
    form.find('#inputSalary').val @model.get 'salary'

    pasition = @model.get 'pasition'
    skillM = @model.get 'skill'
    position = _.find @editionParams.positions, (Obj) ->
       pasition is Obj.positionsName and skillM is Obj.positionsSkill
    form.find('#inputPosition').val position.positionId

    departmName = @model.get 'department'
    departmentId = _.find @editionParams.departments, (Obj) ->
      departmName is Obj.departmentName
    form.find('#inputDepartment').val departmentId.departmentId

    form.find('#inputSkill').val helper.ucfirst position.positionsSkill










