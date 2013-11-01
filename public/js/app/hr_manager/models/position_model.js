// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.PositionModel = (function(_super) {
    __extends(PositionModel, _super);

    function PositionModel() {
      _ref = PositionModel.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    PositionModel.prototype.urlRoot = location.origin + "/position";

    PositionModel.prototype.defaults = {
      name: 'Empty name',
      skills: 'Trainee',
      description: 'Position for reserve',
      department_id: 1,
      date: new Date()
    };

    PositionModel.prototype.validate = function(attrs) {
      if (attrs.name === 'Empty name' || !attrs.name) {
        return 'Validation Error: Fill the Name field';
      }
    };

    return PositionModel;

  })(Backbone.Model);

}).call(this);

/*
//@ sourceMappingURL=position_model.map
*/
