class App.addNewStaff extends App.PopupWondow
  template: new EJS url: 'templates/general/modal-tpl.ejs'
  staffModel: new App.StaffModel

  events:
    "change #inputPosition": "fillSkills"


  initialize: ->
    @model.on('sync', @showForm, @)


  render: (model) ->
    Log model

  showForm: (model) ->
    Log model.toJSON()
    @editionParams = model.toJSON()
    formTpl = new EJS url: 'templates/staff_page/add_employee.ejs'
    Log 'The ADD window is opened'
    @$el.html @template.render
      modalTitle: 'Add New Employee'
      modalBody: formTpl.render
        position: @editionParams.positions
        department: @editionParams.departments

  fillSkills: (eve) ->
    Log "change"
#    skill = $('#inputSkill').val()

#    skill = @$el.find("select option:selected").each() ->
#

#    skill = @$el.find("select option:selected").each() =>
#      @val()== @el.get('skills')


#    Log skill
#    @$el.find('#inputPosition').val()
#    @$el.find('#inputSkill').val(@$el.find('#inputPosition').val())

    positionId = $(eve.target).val()


    position = _.find @editionParams.positions, (Obj) ->
      parseInt(positionId, 10) is parseInt(Obj.positionId, 10)

    Log position

    @$el.find('#inputSkill').val helper.ucfirst position.positionsSkill



