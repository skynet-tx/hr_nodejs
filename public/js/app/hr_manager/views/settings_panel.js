// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Settings = (function(_super) {
    __extends(Settings, _super);

    function Settings() {
      _ref = Settings.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Settings.prototype.el = '.list-container';

    Settings.prototype.template = new EJS({
      url: 'templates/general/list-conainer.ejs'
    });

    Settings.prototype.events = {
      'click #add-new': 'addNewUser',
      'click .btn-edit-record': 'editUser',
      'click .btn-delete-item': 'deleteUser'
    };

    Settings.prototype.initialize = function() {
      this.collection.on('reset', this.addStaffList, this);
      return this.collection.on('destroy', this.reloadGrid, this);
    };

    Settings.prototype.render = function() {
      var seachFormTpl;
      this.$el.html(this.template.render({
        pageName: 'Users list'
      }));
      seachFormTpl = new EJS({
        url: 'templates/position_page/filter_area_tpl.ejs'
      });
      $('.filter-form').prepend(seachFormTpl.render());
      return this;
    };

    Settings.prototype.reloadGrid = function(gridData) {
      var gridTpl;
      $('#grid').html(' ');
      gridTpl = new EJS({
        url: 'templates/users/users-grid.ejs'
      });
      if (gridData && gridData.hasOwnProperty('cid') === false) {
        App.gridData = gridData;
      } else {
        this.$el.find('#search-by').val();
        App.gridData = this.collection.toJSON();
      }
      $('#grid').html(gridTpl.render());
      Log('Grid is reloaded..');
      return this;
    };

    Settings.prototype.addStaffList = function(usersData) {
      var gridTpl;
      gridTpl = new EJS({
        url: 'templates/users/users-grid.ejs'
      });
      this.$el.find('#search-by').val();
      App.gridData = usersData.toJSON();
      $('#grid').html(gridTpl.render());
      Log('Show Grid');
      return this;
    };

    Settings.prototype.addNewUser = function(eve) {
      var addWindow;
      eve.preventDefault();
      addWindow = new App.AddEditUser({
        collection: this.collection
      });
      $('#for-modal').html(addWindow.el);
      $('#popup-window').modal();
      return Log('Add new user window is open');
    };

    Settings.prototype.deleteUser = function(eve) {
      var deleteWindow, model, recordId;
      eve.preventDefault();
      recordId = $(eve.target).attr('data-id');
      model = this.collection.findWhere({
        id: parseInt(recordId, 10)
      });
      deleteWindow = new App.DeleteUserWindow({
        model: model
      });
      $('#for-modal').html(deleteWindow.el);
      $('#popup-window').modal();
      return Log('Delet alert window is open');
    };

    Settings.prototype.editUser = function(eve) {
      var editWindow, recordId, user;
      eve.preventDefault();
      recordId = $(eve.target).attr('data-id');
      user = this.collection.findWhere({
        id: parseInt(recordId, 10)
      });
      editWindow = new App.AddEditUser({
        model: user,
        collection: this.collection,
        isEdit: true
      });
      $('#for-modal').html(editWindow.el);
      $('#popup-window').modal();
      return Log('Edit User window is open');
    };

    return Settings;

  })(App.MainTemplate);

}).call(this);

/*
//@ sourceMappingURL=settings_panel.map
*/
