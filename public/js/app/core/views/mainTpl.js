// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.MainTemplate = (function(_super) {
    __extends(MainTemplate, _super);

    function MainTemplate() {
      _ref = MainTemplate.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    MainTemplate.prototype.initialize = function() {
      return this.render();
    };

    MainTemplate.prototype.close = function() {
      helper.log('Removed all events...');
      this.stopListening();
      return $(this.el).empty();
    };

    return MainTemplate;

  })(Backbone.View);

}).call(this);

/*
//@ sourceMappingURL=mainTpl.map
*/
