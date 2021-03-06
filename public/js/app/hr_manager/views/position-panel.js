// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.PosPanel = (function(_super) {
    __extends(PosPanel, _super);

    function PosPanel() {
      _ref = PosPanel.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    PosPanel.prototype.el = '.list-container';

    PosPanel.prototype.template = new EJS({
      url: 'templates/general/list-conainer.ejs'
    });

    PosPanel.prototype.events = {
      'click #add-new': 'addNewPosition',
      'click .btn-edit-record': 'editPosition',
      'click .btn-delete-item': 'deleteItem',
      'submit': 'seachBy'
    };

    PosPanel.prototype.initialize = function() {
      this.collection.on('reset', this.addPositionsList, this);
      return this.collection.on('destroy', this.reloadGrid, this);
    };

    PosPanel.prototype.render = function() {
      var seachFormTpl;
      this.$el.html(this.template.render({
        pageName: 'List of Positions'
      }));
      seachFormTpl = new EJS({
        url: 'templates/position_page/filter_area_tpl.ejs'
      });
      $('.filter-form').prepend(seachFormTpl.render());
      return this;
    };

    PosPanel.prototype.reloadGrid = function(gridData) {
      var gridTpl;
      $('#grid').html(' ');
      gridTpl = new EJS({
        url: 'templates/position_page/positions-grid.ejs'
      });
      if (gridData && gridData.hasOwnProperty('cid') === false) {
        App.gridData = gridData;
      } else {
        this.$el.find('#search-by').val();
        App.gridData = this.collection.toJSON();
      }
      $('#grid').html(gridTpl.render());
      this._removeDelBtn();
      return Log('Grid is reloaded..');
    };

    PosPanel.prototype.addPositionsList = function(positions) {
      var gridTpl;
      Log('Show Grid');
      gridTpl = new EJS({
        url: 'templates/position_page/positions-grid.ejs'
      });
      this.$el.find('#search-by').val();
      App.gridData = positions.toJSON();
      $('#grid').html(gridTpl.render());
      this._removeDelBtn();
      return this;
    };

    PosPanel.prototype.addNewPosition = function() {
      var addWindow;
      addWindow = new App.addNewPosition({
        collection: this.collection
      });
      $('#for-modal').html(addWindow.el);
      $('#popup-window').modal();
      return Log('Add new position window is open');
    };

    PosPanel.prototype.deleteItem = function(eve) {
      var deleteAlertWindow, model, recordId;
      recordId = $(eve.target).attr('data-id');
      model = this.collection.findWhere({
        id: parseInt(recordId, 10)
      });
      deleteAlertWindow = new App.DeleteAlertWindow({
        model: model
      });
      $('#for-modal').html(deleteAlertWindow.el);
      $('#popup-window').modal();
      return Log('Delet alert window is open');
    };

    PosPanel.prototype.editPosition = function(eve) {
      var addWindow, position, recordId;
      recordId = $(eve.target).attr('data-id');
      position = this.collection.findWhere({
        id: parseInt(recordId, 10)
      });
      addWindow = new App.addNewPosition({
        model: position,
        collection: this.collection,
        isEdit: true
      });
      $('#for-modal').html(addWindow.el);
      $('#popup-window').modal();
      return Log('Edit position window is open');
    };

    PosPanel.prototype.seachBy = function(eve) {
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

    return PosPanel;

  })(App.MainTemplate);

}).call(this);

/*
//@ sourceMappingURL=position-panel.map
*/
