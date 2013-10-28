/**
 * User: osavch
 * Date: 28.10.13
 * Time: 15:57
 * File name:
 */
(function(){
    App.MainTemplate = Backbone.View.extend({
        el: 'body',
        template: new EJS({url: 'templates/general/main-page-tpl.ejs'}),
        initialize: function(){
            this.render();
        }
    });
    return App.MainTemplate;
})()
