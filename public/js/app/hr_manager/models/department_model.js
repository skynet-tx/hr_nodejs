// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.DepartmentModel = (function(_super) {
    __extends(DepartmentModel, _super);

    function DepartmentModel() {
      _ref = DepartmentModel.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    DepartmentModel.prototype.defaults = {
      id: null,
      name: null,
      description: null,
      date: new Date()
    };

    DepartmentModel.prototype.validate = function(attrs) {
      if (attrs.name === null || !attrs.name) {
        return 'Validation Error: Fill the Name field';
      }
    };

    return DepartmentModel;

  })(Backbone.Model);

}).call(this);

/*
//@ sourceMappingURL=department_model.map
*/