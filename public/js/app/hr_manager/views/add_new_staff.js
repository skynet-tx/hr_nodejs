// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.addNewStaff = (function(_super) {
    __extends(addNewStaff, _super);

    function addNewStaff() {
      _ref = addNewStaff.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    addNewStaff.prototype.template = new EJS({
      url: 'templates/general/modal-tpl.ejs'
    });

    addNewStaff.prototype.isEdit = false;

    addNewStaff.prototype.staffModel = new App.StaffModel();

    addNewStaff.prototype.events = {
      'click #form-save': 'eventSelection',
      "change #inputPosition": "fillSkills"
    };

    addNewStaff.prototype.initialize = function(params) {
      this.isEdit = params.isEdit;
      this.model.on('sync', this.showForm, this);
      return this.recordId = params.recordId;
    };

    addNewStaff.prototype.render = function(model) {
      return Log(model);
    };

    addNewStaff.prototype.showForm = function(model) {
      var employeeSurname, formTpl;
      Log(model.toJSON());
      this.editionParams = model.toJSON();
      formTpl = new EJS({
        url: 'templates/staff_page/add_employee.ejs'
      });
      Log(this.editionParams);
      if (!this.isEdit) {
        Log('The ADD window is opened');
        this.$el.html(this.template.render({
          modalTitle: 'Add New Employee',
          modalBody: formTpl.render({
            position: this.editionParams.positions,
            department: this.editionParams.departments
          })
        }));
      } else {
        this.model = this.collection.findWhere({
          id: parseInt(this.recordId, 10)
        });
        employeeSurname = this.model.get('surname');
        this.$el.html(this.template.render({
          modalTitle: 'Edit record "<strong>' + employeeSurname + '</strong>"',
          modalBody: formTpl.render({
            position: this.editionParams.positions,
            department: this.editionParams.departments
          })
        }));
        this._fiilFormValues();
      }
      return this;
    };

    addNewStaff.prototype.eventSelection = function(eve) {
      if (!this.isEdit) {
        return this.saveNewEmployee(eve);
      } else {
        return this.editRecord(eve);
      }
    };

    addNewStaff.prototype.fillSkills = function(eve) {
      var position, positionId;
      positionId = $(eve.target).val();
      position = _.find(this.editionParams.positions, function(Obj) {
        return parseInt(positionId, 10) === parseInt(Obj.positionId, 10);
      });
      Log(position);
      return this.$el.find('#inputSkill').val(helper.ucfirst(position.positionsSkill));
    };

    addNewStaff.prototype.saveNewEmployee = function(eve) {
      var alertTpl,
        _this = this;
      eve.preventDefault();
      alertTpl = new EJS({
        url: 'templates/general/alert-danger-tpl.ejs'
      });
      this.staffModel.set(this._serializeForm());
      this.staffModel.on('invalid', function(model, error) {
        return $('#alert-message').html(alertTpl.render({
          alertMessage: error
        }));
      });
      return this.staffModel.save(this.staffModel.toJSON(), {
        error: function() {
          return $('#alert-message').html(alertTpl.render({
            alertMessage: "Server Error. Can't save your data. Try again later."
          }));
        },
        success: function() {
          $('#popup-window').modal('hide');
          Log('Add new employee window was closed');
          return _this.collection.fetch({
            reset: true
          });
        }
      });
    };

    addNewStaff.prototype._serializeForm = function() {
      var formData, formFields;
      formFields = this.$el.find('#add-employee-form').serializeArray();
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

    addNewStaff.prototype.editRecord = function(eve) {
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

    addNewStaff.prototype._fiilFormValues = function() {
      var departmName, departmentId, form, pasition, position, skillM;
      this.model = this.collection.findWhere({
        id: parseInt(this.recordId, 10)
      });
      Log('model here');
      Log(this.model);
      form = this.$el.find('#add-employee-form');
      form.find('#inputName').val(this.model.get('name'));
      form.find('#inputMiddlename').val(this.model.get('middle_name'));
      form.find('#inputSurname').val(this.model.get('surname'));
      form.find('#inputBirthday').val(this.model.get('birthday'));
      form.find('#inputCity').val(this.model.get('city'));
      form.find('#inputSalary').val(this.model.get('salary'));
      pasition = this.model.get('pasition');
      skillM = this.model.get('skill');
      position = _.find(this.editionParams.positions, function(Obj) {
        return pasition === Obj.positionsName && skillM === Obj.positionsSkill;
      });
      form.find('#inputPosition').val(position.positionId);
      departmName = this.model.get('department');
      departmentId = _.find(this.editionParams.departments, function(Obj) {
        return departmName === Obj.departmentName;
      });
      form.find('#inputDepartment').val(departmentId.departmentId);
      return form.find('#inputSkill').val(helper.ucfirst(position.positionsSkill));
    };

    return addNewStaff;

  })(App.PopupWondow);

}).call(this);

/*
//@ sourceMappingURL=add_new_staff.map
*/
