// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.DepartmentsOptionsList = (function(_super) {
    __extends(DepartmentsOptionsList, _super);

    function DepartmentsOptionsList() {
      _ref = DepartmentsOptionsList.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    DepartmentsOptionsList.prototype.tagName = 'select';

    DepartmentsOptionsList.prototype.className = 'form-control';

    DepartmentsOptionsList.prototype.attributes = {
      id: 'inputDepartments',
      name: 'department_id'
    };

    DepartmentsOptionsList.prototype.initialize = function() {
      return this.collection.on('sync', this.render, this);
    };

    DepartmentsOptionsList.prototype.render = function(list) {
      var data, el, liTpl;
      data = list.toJSON();
      liTpl = new EJS({
        url: 'templates/department_page/option_li_list.ejs'
      });
      el = this.$el;
      return _.each(data, function(obj, key) {
        return el.append(liTpl.render({
          id: obj.id,
          name: obj.name
        }));
      });
    };

    return DepartmentsOptionsList;

  })(App.MainTemplate);

}).call(this);

/*
//@ sourceMappingURL=departments_options_list.map
*/
