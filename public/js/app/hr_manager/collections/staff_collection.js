// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.StaffColl = (function(_super) {
    __extends(StaffColl, _super);

    function StaffColl() {
      _ref = StaffColl.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    StaffColl.prototype.url = location.origin + '/staff-list';

    StaffColl.prototype.model = App.StaffModel;

    return StaffColl;

  })(Backbone.Collection);

}).call(this);

/*
//@ sourceMappingURL=staff_collection.map
*/
