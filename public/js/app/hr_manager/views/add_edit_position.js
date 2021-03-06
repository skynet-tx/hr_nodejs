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
      'click #form-save': 'eventSelection'
    };

    addNewPosition.prototype.initialize = function(params) {
      this.isEdit = params.isEdit;
      return this.render();
    };

    addNewPosition.prototype.render = function() {
      var formTpl, list, positionName;
      formTpl = new EJS({
        url: 'templates/position_page/add-form.ejs'
      });
      list = this._getSelectDept();
      if (!this.isEdit) {
        this.$el.html(this.template.render({
          modalTitle: 'Add New Position',
          modalBody: formTpl.render()
        }));
        this.$el.find('.dep-list').html(list);
      } else {
        positionName = this.model.get('name');
        this.$el.html(this.template.render({
          modalTitle: 'Edit record "<strong>' + positionName + '</strong>"',
          modalBody: formTpl.render()
        }));
        this.$el.find('.dep-list').html(list);
        this._fiilFormValues();
      }
      return this;
    };

    addNewPosition.prototype.eventSelection = function(eve) {
      if (!this.isEdit) {
        return this.saveNewPosition(eve);
      } else {
        return this.editRecord(eve);
      }
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

    addNewPosition.prototype._getSelectDept = function() {
      var departmentList, options;
      departmentList = new App.DepartmentsListColl();
      departmentList.fetch();
      options = new App.DepartmentsOptionsList({
        collection: departmentList
      });
      return options.el;
    };

    addNewPosition.prototype.editRecord = function(eve) {
      var alertTpl,
        _this = this;
      eve.preventDefault();
      alertTpl = new EJS({
        url: 'templates/general/alert-danger-tpl.ejs'
      });
      this.model.set(this._serializeForm());
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

    addNewPosition.prototype._fiilFormValues = function() {
      var form,
        _this = this;
      form = this.$el.find('#add-position-form');
      form.find('#inputName').val(this.model.get('name'));
      form.find('#inputDescription').val(this.model.get('description'));
      form.find('#inputSkills').children().each(function(key, el) {
        if ($(el).val() === _this.model.get('skills')) {
          return $(el).attr('selected', 'selected');
        }
      });
      return setTimeout(function() {
        return form.find('#inputDepartments').children().each(function(key, el) {
          if (parseInt($(el).val()) === parseInt(_this.model.get('department_id'))) {
            return $(el).attr('selected', 'selected');
          }
        });
      }, 300);
    };

    return addNewPosition;

  })(App.PopupWondow);

}).call(this);

/*
//@ sourceMappingURL=add_edit_position.map
*/
