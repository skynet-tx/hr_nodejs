/**
 * User: osavch
 * Date: 25.10.13
 * Time: 16:32
 * File name:
 */
App = {};

App = {
    Models: {},
    Views: {},
    Collections: {},
    Controller: {}
};

$(function(){
    App.Start = Backbone.Router.extend({
        routes: {
            '(staff)': 'staff',
            'departmant': 'departmant',
            'positions': 'positions',
            '*path': 'notFound'
        },

        staff: function(){
            Include({src: 'js/app/hr_manager/views/staff_page.js'});
            var test = new App.StaffPage();
            helper.selectMenuButton();
            Log('page: staff');
        },

        departmant: function() {
            helper.selectMenuButton();
            helper.log('page: departmant');
        },

        positions: function() {
            helper.selectMenuButton();
            helper.log('page: positions');
        },

        notFound: function(path) {
            alert('Sorry! There is no content here.');
        }
    });

    var startApp = new App.Start()
    Backbone.history.start();

});


/**
 * Load files to application
 * Core Models
 */
//helper.loadFile('js/app/core/models/baseModel.js');


