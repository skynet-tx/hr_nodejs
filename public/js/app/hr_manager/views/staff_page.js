/**
 * User: osavch
 * Date: 28.10.13
 * Time: 16:00
 * File name:
 */
Include({src: 'js/app/core/views/mainTpl.js'}, true);

App.StaffPage = App.MainTemplate.extend({
    el: 'body',
    template: new EJS({url: 'templates/general/main-page-tpl.ejs'}),
    render: function(){
        this.$el.html(this.template.render());
        return this;
    }
});
