/**
 * User: osavch
 * Date: 25.10.13
 * Time: 16:32
 * File name:
 */
var App = {};

App = {
    Models: {},
    Views: {},
    Collections: {},
    Controller: {}
};

$(function () {
    App.Start = Backbone.Router.extend({
        currentView: null,
        routes: {
            '(staff)': 'staff',
            'departmant': 'departmant',
            'positions': 'positions',
            'login': 'login',
            'adm/settings': 'settings',
            '*path': 'notFound'
        },

        initialize: function () {
                this.loadAppPage();
        },

        loadAppPage: function () {
            requere([
                'js/app/hr_manager/models/add_edit_employee.js',

                'js/app/hr_manager/models/app_model.js',
                'js/app/hr_manager/views/staff_page.js'
            ]);

            var model = new App.ApplicationModel();
            model.fetch();

            new App.StaffPage({model: model});
            Log('Init main page');
        },

        staff: function () {
            this.reloadMainPage();
            this.currentView ? this.currentView.close() : null;
            requere([
                'js/app/hr_manager/models/app_model.js',
                'js/app/hr_manager/models/staff_model.js',
                'js/app/hr_manager/models/add_edit_employee.js',
                'js/app/hr_manager/collections/staff_collection.js',
                'js/app/hr_manager/views/staff_panel.js',
                'js/app/hr_manager/collections/postions_collection.js',
                'js/app/hr_manager/collections/departments_list_coll.js',
                'js/app/core/views/popupWindow.js',
                'js/app/hr_manager/views/add_new_staff.js'


            ]);



            var staffList = new App.StaffColl();
            this.currentView = new App.StaffPanel({collection: staffList});
            this.currentView.render();

            staffList.fetch({reset: true});
            helper.selectMenuButton();
            Log('page: staff');
        },


        departmant: function () {
            this.reloadMainPage();
            this.currentView ? this.currentView.close() : null;
            requere([
                'js/app/hr_manager/models/department_model.js',
                'js/app/hr_manager/collections/departments_list_coll.js',
                'js/app/hr_manager/views/department_panel.js',
                'js/app/core/views/popupWindow.js',
                'js/app/hr_manager/views/add_new_department.js',
                'js/app/hr_manager/views/delete-deptm-alert-window.js'

            ]);

            var departments = new App.DepartmentsListColl();
            this.currentView = new App.DepPanel({collection: departments});
            this.currentView.render();

            departments.fetch();
            helper.selectMenuButton();
            Log('page: departmant');
        },

        positions: function () {
            this.reloadMainPage();
            this.currentView ? this.currentView.close() : null;
            requere([
                'js/app/hr_manager/models/position_model.js',
                'js/app/hr_manager/collections/postions_collection.js',
                'js/app/core/views/popupWindow.js',
                'js/app/hr_manager/views/add_edit_position.js',
                'js/app/hr_manager/views/position-panel.js',
                'js/app/hr_manager/views/delete-alert-window.js',
                'js/app/hr_manager/models/department_model.js',
                'js/app/hr_manager/collections/departments_list_coll.js',
                'js/app/hr_manager/views/departments_options_list.js'
            ]);

            var positions = new App.PosColl();
            this.currentView = new App.PosPanel({collection: positions});
            this.currentView.render();

            positions.fetch({reset: true});
            helper.selectMenuButton();
            Log('page: positions');
        },

        settings: function() {
            this.reloadMainPage();
            this.currentView ? this.currentView.close() : null;
            helper.selectMenuButton();

            if(Cookie.get('role') !== 'admin'){
               this.navigate('/staff', {trigger: true, replace: true});
            }

            requere([
                'js/app/hr_manager/models/user_model.js',
                'js/app/hr_manager/collections/users_collection.js',
                'js/app/core/views/popupWindow.js',
                'js/app/hr_manager/views/add_edit_user.js',
                'js/app/hr_manager/views/settings_panel.js',
                'js/app/hr_manager/views/delete_user_window.js'
            ]);

            var users = new App.Users();
            this.currentView = new App.Settings({collection: users});
            this.currentView.render();

            users.fetch({reset: true});
            Log('page: settings');
        },

        login: function () {
            this.currentView ? this.currentView.remove() : null;
            requere([
                'js/app/hr_manager/models/login_model.js',
                'js/app/hr_manager/views/login_view.js'
            ]);
            var loginModel = new App.LoginModel();
            this.currentView = new App.LoginView({model: loginModel});
            Log('Login page');
        },

        notFound: function (path) {
            alert('Sorry! There is no content here.');
        },

        reloadMainPage: function(){
            if ($('.container.main-page').length < 1)
                this.loadAppPage();

        }
    });

    App.startApp = new App.Start()
    Backbone.history.start();

});


/**
 * Load files to application
 * Core Models
 */
//helper.loadFile('js/app/core/models/baseModel.js');


