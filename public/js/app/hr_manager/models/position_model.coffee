class App.PositionModel extends Backbone.Model
  urlRoot: location.origin + "/positions"
  defaults:
    name: 'Empty name'
    skills: 'Trainee'
    description: 'Position for reserve'
  validate: (attrs) ->
    'Validation Error: Fill the Name field' if (attrs.name is 'Empty name' or not attrs.name)
