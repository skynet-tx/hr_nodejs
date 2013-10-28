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

    loadFile: function (path, isInclude) {
        var self = this,
            scriptTpl = [],
            tpl = null,
            type = isInclude ? 'append' : 'html';

        if (typeof(path) != "object") {
            throw  "The variable is not an Object!"
        }


        $.each(path, function (key, val) {
            scriptTpl.push("<script class='temp-script' src=" + path.src + "></script>");
        });

        if (!isInclude && $('.temp-script12').length === 0) {
            $('.temp-script').remove();
            $('head').append(scriptTpl.join(' '));
        } else {
            $('.temp-script').before(scriptTpl.join(' '));
        }
    },

    selectMenuButton: function (btn) {
        if(!btn){
           var locationHash = location.hash;
            btn = !locationHash.substr(1) ? 'staff' : locationHash.substr(1);
        }

        $('.main-menu a').each(function (key, el) {
            if ($(el).attr('data-btn') === btn) {
                $(el).addClass('btn-success');
                $(el).removeClass('btn-primary');
            } else {
                $(el).removeClass('btn-success');
                $(el).addClass('btn-primary');
            }
        });
    }
}

helper = Object.seal(helper);

/**
 * Shot name of helper.log
 * @param val
 * @returns {*}
 * @constructor
 */
var Log = function (val) {
    return helper.log(val);
}

/**
 * Shot name of helper.loadFile
 * @param pathObj
 * @param isInclude
 * @returns {*}
 * @constructor
 */
var Include = function (pathObj, isInclude) {
    return helper.loadFile(pathObj, isInclude);
}



