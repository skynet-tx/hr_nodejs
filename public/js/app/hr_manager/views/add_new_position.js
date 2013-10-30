// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.addNewPosition = (function(_super) {
    __extends(addNewPosition, _super);

    function addNewPosition() {
      _ref = addNewPosition.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    addNewPosition.prototype.template = new EJS({
      url: 'templates/general/modal-tpl.ejs'
    });

    addNewPosition.prototype.isEdit = false;

    addNewPosition.prototype.model = new App.PositionModel;

    addNewPosition.prototype.events = {
      'click #form-save': 'saveNewPosition'
    };

    addNewPosition.prototype.initialize = function() {
      return this.render();
    };

    addNewPosition.prototype.render = function() {
      var formTpl;
      formTpl = new EJS({
        url: 'templates/position_page/add-form.ejs'
      });
      this.$el.html(this.template.render({
        modalTitle: 'Add New Position',
        modalBody: formTpl.render()
      }));
      return this;
    };

    addNewPosition.prototype.saveNewPosition = function(eve) {
      var alertTpl,
        _this = this;
      eve.preventDefault();
      alertTpl = new EJS({
        url: 'templates/general/alert-danger-tpl.ejs'
      });
      this.model.set(this._serializeForm());
      this.model.on('invalid', function(model, error) {
        return $('#alert-message').html(alertTpl.render({
          alertMessage: error
        }));
      });
      return this.model.save(this.model.toJSON(), {
        error: function() {
          return $('#alert-message').html(alertTpl.render({
            alertMessage: "Server Error. Can't save your data. Try again later."
          }));
        },
        success: function() {
          $('#popup-window').modal('hide');
          Log('Add new position window was closed');
          return _this.collection.fetch({
            reset: true
          });
        }
      });
    };

    addNewPosition.prototype._serializeForm = function() {
      var formData, formFields;
      formFields = this.$el.find('#add-position-form').serializeArray();
      formData = {};
      $.each(formFields, function(key, obj) {
        if (!obj['value']) {
          null;
        }
        return formData[obj['name']] = obj['value'];
      });
      formData['date'] = new Date();
      return formData;
    };

    return addNewPosition;

  })(App.PopupWondow);

}).call(this);

/*
//@ sourceMappingURL=add_new_position.map
*/
