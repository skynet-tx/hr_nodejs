/**
* User: osavch
* Date: 16.10.13
* Time: 12:05
* File name:
*/
var helper = {
    logType: 'dir', // log , dir
    isDeveloper: true,
    countLogs: 0,

    log: function (val) {
        if (!this.isDeveloper) return;
        var self = this;

        console.log(++this.countLogs + ' Debugger log(s):');
        _.each(arguments, function (argument) {
            console[self.logType](argument);
        });
    },

    loadFile: function (path) {
        var self = this;
        $.getScript(path)
            .done(function (script, textStatus) {
                self.log( 'file - ' + path + ' loaded: ' + textStatus);
            })
            .fail(function (jqxhr, settings, exception) {
                self.log("Triggered ajaxError handler.");
            });
    }


}

helper = Object.seal(helper);



