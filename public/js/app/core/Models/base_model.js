// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.BaseModel = (function(_super) {
    __extends(BaseModel, _super);

    function BaseModel() {
      _ref = BaseModel.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    defaults({
      date: new Date
    });

    return BaseModel;

  })(Backbone.Model);

}).call(this);

/*
//@ sourceMappingURL=base_model.map
*/
