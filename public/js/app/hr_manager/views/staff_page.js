/**
 * User: osavch
 * Date: 28.10.13
 * Time: 16:00
 * File name:
 */
App.StaffPage = Backbone.View.extend({
    render: function(){
        this.$el.html(this.template().render());
        helper.dataPickerStart();
        return this;
    }
});
