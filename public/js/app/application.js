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

$(function(){
    App.Start = Backbone.Router.extend({
        currentView: null,
        routes: {
            '(staff)': 'staff',
            'departmant': 'departmant',
            'positions': 'positions',
            'login': 'login',
            '*path': 'notFound'
        },

        initialize: function(){
            this.loadAppPage();
        },

        loadAppPage: function(){
            requere('js/app/hr_manager/views/staff_page.js');
            new App.StaffPage();
        },

        staff: function(){
            this.currentView ? this.currentView.close() : null;
            requere([
                'js/app/hr_manager/models/staff_model.js',
                'js/app/hr_manager/collections/staff_collection.js',
                'js/app/hr_manager/views/staff_panel.js',
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



        departmant: function() {
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

        positions: function() {
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

        login: function() {
            this.currentView ? this.currentView.remove() : null;
            requere([
                'js/app/hr_manager/models/login_model.js',
                'js/app/hr_manager/views/login_view.js'
            ]);

            this.currentView = new App.LoginView
            Log('Login page');
        },

        notFound: function(path) {
            alert('Sorry! There is no content here.');
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


