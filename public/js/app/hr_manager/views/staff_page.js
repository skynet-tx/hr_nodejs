// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  include(['js/app/core/views/mainTpl.js']);

  App.StaffPage = (function(_super) {
    __extends(StaffPage, _super);

    function StaffPage() {
      _ref = StaffPage.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    StaffPage.prototype.el = 'body';

    StaffPage.prototype.template = new EJS({
      url: 'templates/general/main-page-tpl.ejs'
    });

    StaffPage.prototype.events = {
      'click .btn-logout': 'logout'
    };

    StaffPage.prototype.initialize = function(attrs) {
      this.positions = attrs.positions;
      this.model.on('sync', this.setAuth, this);
      return this.render();
    };

    StaffPage.prototype.render = function() {
      this.$el.html(this.template.render());
      return this;
    };

    StaffPage.prototype.setAuth = function(model) {
      this.isLoggin = model.get('isLoggin');
      if (!this.isLoggin) {
        App.startApp.navigate('/login', {
          trigger: true,
          replace: true
        });
      }
      this._setAuthorizedAs(model.get('authorizedAs'));
      return this._setSettingsLink(model.get('role'));
    };

    StaffPage.prototype.logout = function() {
      var _this = this;
      this.model.set({
        isLoggin: false
      });
      return this.model.save(this.model.toJSON(), {
        error: function() {
          return $('#alert-message').html(alertTpl.render({
            alertMessage: "Server Error. Can't save your data. Try again later."
          }));
        },
        success: function() {
          return window.location.href = location.origin + '/#login';
        }
      });
    };

    StaffPage.prototype._setAuthorizedAs = function(email) {
      return this.$el.find('.authorizedAs').text(email);
    };

    StaffPage.prototype._setSettingsLink = function(role) {
      var linkTpl;
      linkTpl = '<a href="/#adm/settings" class="btn btn-link glyphicon glyphicon-wrench btn-settings"></a>';
      if (role === 'admin') {
        this.$el.find('.page-settings').append(linkTpl);
        return App.checkIsAdmin = true;
      }
    };

    return StaffPage;

  })(App.MainTemplate);

}).call(this);

/*
//@ sourceMappingURL=staff_page.map
*/
