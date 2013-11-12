// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.StaffPanel = (function(_super) {
    __extends(StaffPanel, _super);

    function StaffPanel() {
      _ref = StaffPanel.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    StaffPanel.prototype.el = '.list-container';

    StaffPanel.prototype.template = new EJS({
      url: 'templates/general/list-conainer.ejs'
    });

    StaffPanel.prototype.events = {
      'click #add-new': 'addNewEmployee',
      'click .btn-edit-record2': 'editEmployee',
      'click .btn-delete-item2': 'deleteEmployee',
      'submit': 'seachBy'
    };

    StaffPanel.prototype.initialize = function() {
      this.collection.on('reset', this.addStaffList, this);
      return this.collection.on('destroy', this.reloadGrid, this);
    };

    StaffPanel.prototype.render = function() {
      var seachFormTpl;
      this.$el.html(this.template.render({
        pageName: 'Staff list'
      }));
      seachFormTpl = new EJS({
        url: 'templates/position_page/filter_area_tpl.ejs'
      });
      $('.filter-form').prepend(seachFormTpl.render());
      return this;
    };

    StaffPanel.prototype.reloadGrid = function(gridData) {
      var gridTpl;
      $('#grid').html(' ');
      gridTpl = new EJS({
        url: 'templates/staff_page/staff_grid.ejs'
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

    StaffPanel.prototype.addStaffList = function(staff) {
      var gridTpl;
      gridTpl = new EJS({
        url: 'templates/staff_page/staff_grid.ejs'
      });
      this.$el.find('#search-by').val();
      App.gridData = staff.toJSON();
      $('#grid').html(gridTpl.render());
      return this;
    };

    StaffPanel.prototype.addNewEmployee = function() {
      var addWindow, selectModel;
      selectModel = new App.AddEditEmployee;
      selectModel.fetch();
      addWindow = new App.addNewStaff({
        collection: this.collection,
        model: selectModel
      });
      $('#for-modal').html(addWindow.el);
      $('#popup-window').modal();
      return Log('Add new staff window is open');
    };

    StaffPanel.prototype.editEmployee = function(eve) {
      var addWindow, recordId, selectModel;
      selectModel = new App.AddEditEmployee();
      selectModel.fetch();
      recordId = $(eve.target).attr('data-id');
      addWindow = new App.addNewStaff({
        collection: this.collection,
        model: selectModel,
        recordId: recordId,
        isEdit: true
      });
      $('#for-modal').html(addWindow.el);
      $('#popup-window').modal();
      return Log('Edit employee window is open');
    };

    StaffPanel.prototype.deleteEmployee = function(eve) {
      var deleteAlertWindow, recordId, selectModel;
      selectModel = new App.AddEditEmployee();
      selectModel.fetch();
      recordId = $(eve.target).attr('data-id');
      selectModel = this.collection.findWhere({
        id: parseInt(recordId, 10)
      });
      deleteAlertWindow = new App.DeleteEmplAlertWindow({
        collection: this.collection,
        model: selectModel,
        recordId: recordId
      });
      $('#for-modal').html(deleteAlertWindow.el);
      $('#popup-window').modal();
      return Log('Delet alert window is open');
    };

    StaffPanel.prototype.seachBy = function(eve) {
      var formValue, searchData, staffList;
      eve.preventDefault();
      formValue = this.$el.find('.filter-form input').val().toLowerCase().trim();
      staffList = this.collection.toJSON();
      searchData = _.filter(staffList, function(obj) {
        var keys, value_keys;
        keys = null;
        _.each(obj, function(val, key) {
          var value;
          value = obj[key] + '';
          if (value.toLowerCase() === formValue) {
            keys = key;
          }
          if (!obj[key] || obj[key] === null) {

          }
        });
        value_keys = obj[keys] + '';
        return value_keys.toLowerCase() === formValue;
      });
      if (searchData.length > 0) {
        return this.reloadGrid(searchData);
      } else {
        return this.reloadGrid();
      }
    };

    return StaffPanel;

  })(App.MainTemplate);

}).call(this);

/*
//@ sourceMappingURL=staff_panel.map
*/
