class App.PositionModel extends Backbone.Model
  urlRoot: location.origin + "/position"
  defaults:
    id: null
    name: 'Empty name'
    skills: 'Trainee'
    description: 'Position for reserve'
    date: new Date()

  validate: (attrs) ->
    'Validation Error: Fill the Name field' if (attrs.name is 'Empty name' or not attrs.name)
