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

            this.currentView = null; // TODO make view
            helper.selectMenuButton();
            Log('page: staff');
        },

        departmant: function() {
            this.currentView ? this.currentView.close() : null;
            requere([
                'js/app/hr_manager/models/department_model.js',
                'js/app/hr_manager/collections/departments_list_coll.js',
                'js/app/hr_manager/views/department-panel.js'
            ]);

            var departments = new App.DepartmentsListColl();
            this.currentView = new App.Dep.Panel({collection: departments});
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
                'js/app/hr_manager/views/add_new_position.js',
                'js/app/hr_manager/views/position-panel.js',
                'js/app/hr_manager/views/delete-alert-window.js',
                'js/app/hr_manager/models/department_model.js',
                'js/app/hr_manager/collections/departments_list_coll.js',
                'js/app/hr_manager/views/departments_options_list.js'
            ]);

            var positions = new App.PosColl();
            this.currentView = new App.PosPanel({collection: positions});
            this.currentView.render();

            positions.fetch();
            helper.selectMenuButton();
            Log('page: positions');
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


