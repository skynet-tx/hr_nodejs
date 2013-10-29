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

    /**
     * Dynamically loading file JavaScript
     * The loading is in the head section of the dom
     * Can load js file and make
     * @param path
     * @param isInclude
     */
    loadFile: function (path, isInclude) {
        var scriptTpl = [];

        if (typeof(path) === "string") {
            scriptTpl.push("<script class='temp-script' src=" + path + "></script>");
        } else {
            _.each(path, function (val) {
                scriptTpl.push("<script class='temp-script' src=" + val + "></script>");
            });
        }

        if (!isInclude && $('.temp-script12').length === 0) {
            $('.temp-script').remove();
            $('head').append(scriptTpl.join(' '));
        } else {
            $('.temp-script').before(scriptTpl.join(' '));
        }
    },

    selectMenuButton: function (btn) {
        if (!btn) {
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
 * Add js library
 * @param pathObj
 * @param isInclude
 * @returns {*}
 * @constructor
 */
var include = function (path) {
    return helper.loadFile(path, true);
}

/**
 * Shot name of helper.loadFile
 * connect file js
 * @param pathObj
 * @returns {*}
 */
var requere = function (path) {
    return helper.loadFile(path, false);
}



