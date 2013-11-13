// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.DepPanel = (function(_super) {
    __extends(DepPanel, _super);

    function DepPanel() {
      _ref = DepPanel.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    DepPanel.prototype.el = '.list-container';

    DepPanel.prototype.template = new EJS({
      url: 'templates/general/list-conainer.ejs'
    });

    DepPanel.prototype.events = {
      'click #add-new': 'addNewDepartment',
      'click .btn-edit-record': 'editDepartment',
      'click .btn-delete-item': 'deleteItem',
      'submit': 'seachBy'
    };

    DepPanel.prototype.initialize = function() {
      Log('departments');
      this.collection.on('sync', this.addDepartmentList, this);
      return this.collection.on('destroy', this.reloadGrid, this);
    };

    DepPanel.prototype.render = function() {
      var seachFormTpl;
      this.$el.html(this.template.render({
        pageName: 'List of Departments'
      }));
      seachFormTpl = new EJS({
        url: 'templates/position_page/filter_area_tpl.ejs'
      });
      $('.filter-form').prepend(seachFormTpl.render());
      return this;
    };

    DepPanel.prototype.reloadGrid = function(gridData) {
      var gridTpl;
      $('#grid').html(' ');
      gridTpl = new EJS({
        url: 'templates/department_page/department-grid.ejs'
      });
      if (gridData) {
        App.gridData = gridData;
      } else {
        this.$el.find('#search-by').val();
        App.gridData = this.collection.toJSON();
      }
      $('#grid').html(gridTpl.render());
      return Log('Grid is reloaded..');
    };

    DepPanel.prototype.addDepartmentList = function(departments) {
      var gridTpl;
      Log('Show Grid');
      gridTpl = new EJS({
        url: 'templates/department_page/department-grid.ejs'
      });
      Log('departments');
      App.gridData = departments.toJSON();
      $('#grid').html(gridTpl.render());
      return this;
    };

    DepPanel.prototype.addNewDepartment = function() {
      var addWindow;
      addWindow = new App.addNewDepartment({
        collection: this.collection
      });
      $('#for-modal').html(addWindow.el);
      $('#popup-window').modal();
      return Log('Add new department window open');
    };

    DepPanel.prototype.editDepartment = function(eve) {
      var addWindow, department, recordId;
      Log("Edit button clicked");
      recordId = $(eve.target).attr('data-id');
      department = this.collection.findWhere({
        id: parseInt(recordId, 10)
      });
      addWindow = new App.addNewDepartment({
        model: department,
        collection: this.collection,
        isEdit: true
      });
      $('#for-modal').html(addWindow.el);
      $('#popup-window').modal();
      return Log('Edit department window is open');
    };

    DepPanel.prototype.deleteItem = function(eve) {
      var deleteAlertWindow, model, recordId;
      recordId = $(eve.target).attr('data-id');
      model = this.collection.findWhere({
        id: parseInt(recordId, 10)
      });
      deleteAlertWindow = new App.DeleteDepAlertWindow({
        model: model
      });
      $('#for-modal').html(deleteAlertWindow.el);
      $('#popup-window').modal();
      return Log('Delet alert window is open');
    };

    DepPanel.prototype.seachBy = function(eve) {
      var coll, formValue, searchData;
      eve.preventDefault();
      formValue = this.$el.find('.filter-form input').val().toLowerCase().trim();
      coll = this.collection.toJSON();
      searchData = helper.filterSearch(coll, formValue);
      if (searchData.length > 0) {
        return this.reloadGrid(searchData);
      } else {
        return this.reloadGrid();
      }
    };

    return DepPanel;

  })(App.MainTemplate);

}).call(this);

/*
//@ sourceMappingURL=department_panel.map
*/
