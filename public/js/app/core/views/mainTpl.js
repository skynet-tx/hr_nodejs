/**
 * User: osavch
 * Date: 28.10.13
 * Time: 15:57
 * File name:
 */


App.MainTemplate = Backbone.View.extend({
    initialize: function(){
        this.render();
    },
    close: function () {
        helper.log('Removed all events...');
        this.stopListening();
        this.remove();
    }
});

