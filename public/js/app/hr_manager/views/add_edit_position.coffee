class App.addNewPosition extends App.PopupWondow
  template: new EJS url: 'templates/general/modal-tpl.ejs'
  isEdit: false
  model: new App.PositionModel

  events:
    'click #form-save': 'eventSelection'

  initialize: (params) ->
    @isEdit = params.isEdit
    @render()

  render: ->
    formTpl = new EJS url: 'templates/position_page/add-form.ejs'
    list = @_getSelectDept()

    if not @isEdit
      @$el.html @template.render
        modalTitle: 'Add New Position'
        modalBody: formTpl.render()
      @$el.find('.dep-list').html(list)
    else
      positionName = @model.get 'name'
      @$el.html @template.render
        modalTitle: 'Edit record "<strong>' + positionName + '</strong>"'
        modalBody: formTpl.render()
      @$el.find('.dep-list').html(list)
      @_fiilFormValues()
    @

  eventSelection: (eve) ->
    if not @isEdit
      @saveNewPosition eve
    else
      @editRecord eve

  saveNewPosition: (eve) ->
    eve.preventDefault()
    alertTpl = new EJS url: 'templates/general/alert-danger-tpl.ejs'
    @model.set(@_serializeForm())
    @model.on 'invalid', (model, error) =>
      $('#alert-message').html(alertTpl.render alertMessage: error)
    @model.save @model.toJSON(),
      error: ->
        $('#alert-message').html alertTpl.render
          alertMessage: "Server Error. Can't save your data. Try again later."

      success: =>
        $('#popup-window').modal 'hide'
        Log('Add new position window was closed')
        @collection.fetch({reset: true})

  _serializeForm: ->
    formFields = @$el.find('#add-position-form').serializeArray()
    formData = {}

    $.each formFields, (key, obj)  ->
      null if not obj['value']
      formData[obj['name']] = obj['value']

    formData['date'] = new Date()
    formData

  _getSelectDept: ->
    departmentList = new App.DepartmentsListColl()
    departmentList.fetch()
    options = new App.DepartmentsOptionsList({collection: departmentList})
    options.el

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
        Log('Add new position window was closed')
        @collection.fetch({reset: true})

  _fiilFormValues: ->
    form = @$el.find '#add-position-form'
    form.find('#inputName').val @model.get 'name'
    form.find('#inputDescription').val @model.get 'description'

    form.find('#inputSkills').children().each (key, el) =>
      if $(el).val() == @model.get 'skills'
        $(el).attr 'selected', 'selected'

    setTimeout => # Waiting for the element when loaded
      form.find('#inputDepartments').children().each (key, el) =>
        if parseInt($(el).val()) == parseInt(@model.get 'department_id')
          $(el).attr 'selected', 'selected'
    , 300
