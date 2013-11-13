class App.addNewStaff extends App.PopupWondow

  template: new EJS url: 'templates/general/modal-tpl.ejs'
  isEdit: false
  staffModel: new App.StaffModel()

  events:
    'click #form-save': 'eventSelection'
    'change #inputDepartment': 'onSetPositions'
    'change #inputPosition': 'onFillSkills'


  initialize: (params) ->
    @isEdit = params.isEdit
    @model.on('sync', @showForm, @)
    @recordId = params.recordId

  showForm: (model) ->
    @editionParams = model.toJSON()
    formTpl = new EJS url: 'templates/staff_page/add_employee.ejs'

    if not @isEdit
      @$el.html @template.render
        modalTitle: 'Add New Employee'
        modalBody: formTpl.render
          department: @editionParams.departments
#          position: @editionParams.positions

    else
      @model = @collection.findWhere id: parseInt(@recordId, 10)
      employeeSurname = @model.get 'surname'
      @$el.html @template.render
        modalTitle: 'Edit record "<strong>' + employeeSurname + '</strong>"'
        modalBody: formTpl.render
          department: @editionParams.departments
#          position: @editionParams.positions
      @_fiilFormValues()

    @setPositions()

    Log 'The Add employee window is opened'
    @

  eventSelection: (eve) ->
    if not @isEdit
      @saveNewEmployee eve
    else
      @editRecord eve

  onSetPositions: (eve) ->
    departmentId = $(eve.target).val()
    @setPositions(departmentId)

  setPositions: (departmentId) ->
    optionsTpl = new EJS url: 'templates/staff_page/positions-options.ejs'
    if not departmentId
      departmentId = @$el.find('#inputDepartment').val()

    positions = _.filter @editionParams.positions, (obj) ->
      obj.posDepartId is parseInt departmentId, 10

    @$el.find('#inputPosition').html optionsTpl.render position: positions
    @fillSkill()

  onFillSkills: (eve) ->
    positionId = $(eve.target).val()
    @fillSkill(positionId)

  fillSkill: (positionId) ->
    if not positionId
      positionId = @$el.find('#inputPosition').val()
    position = _.find @editionParams.positions, (Obj) ->
      parseInt(positionId, 10) is parseInt(Obj.positionId, 10)

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










