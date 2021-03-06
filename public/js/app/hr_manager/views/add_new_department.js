// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.addNewDepartment = (function(_super) {
    __extends(addNewDepartment, _super);

    function addNewDepartment() {
      _ref = addNewDepartment.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    addNewDepartment.prototype.template = new EJS({
      url: 'templates/general/modal-tpl.ejs'
    });

    addNewDepartment.prototype.isEdit = false;

    addNewDepartment.prototype.model = new App.DepartmentModel;

    addNewDepartment.prototype.events = {
      'click #form-save': 'eventSelection'
    };

    addNewDepartment.prototype.initialize = function(params) {
      this.isEdit = params.isEdit;
      return this.render();
    };

    addNewDepartment.prototype.render = function() {
      var departmentName, formTpl;
      formTpl = new EJS({
        url: 'templates/department_page/add-dep-form.ejs'
      });
      Log('The window is opened');
      if (!this.isEdit) {
        this.$el.html(this.template.render({
          modalTitle: 'Add New Department',
          modalBody: formTpl.render()
        }));
      } else {
        departmentName = this.model.get('name');
        this.$el.html(this.template.render({
          modalTitle: 'Edit record "<strong>' + departmentName + '</strong>"',
          modalBody: formTpl.render()
        }));
      }
      return this;
    };

    addNewDepartment.prototype.eventSelection = function(eve) {
      if (!this.isEdit) {
        return this.saveNewDepartment(eve);
      } else {
        return this.editRecord(eve);
      }
    };

    addNewDepartment.prototype.saveNewDepartment = function(eve) {
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
          Log('Add new department window was closed');
          return _this.collection.fetch({
            reset: true
          });
        }
      });
    };

    addNewDepartment.prototype._serializeForm = function() {
      var formData, formFields;
      formFields = this.$el.find('#add-department-form').serializeArray();
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

    addNewDepartment.prototype.editRecord = function(eve) {
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
          Log('Add new department window was closed');
          return _this.collection.fetch({
            reset: true
          });
        }
      });
    };

    addNewDepartment.prototype._fiilFormValues = function() {
      var form;
      form = this.$el.find('#add-dep-form');
      form.find('#inputName').val(this.model.get('name'));
      return form.find('#inputDescription').val(this.model.get('description'));
    };

    return addNewDepartment;

  })(App.PopupWondow);

}).call(this);

/*
//@ sourceMappingURL=add_new_department.map
*/
