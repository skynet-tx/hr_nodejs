/**
 * User: osavch
 * Date: 25.10.13
 * Time: 14:42
 * File name:
 */
var express = require('express'),
    app = express(),
    port = process.env.PORT || 3000,
    path = require("path"),
    application_root = __dirname,
    mysql      = require('mysql');

// Config
app.configure(function () {
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
   app.use(express.static(path.join(__dirname, "public")));
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.get('/help', function (req, res) {
    res.send('Hello, World!')
})

app.listen(port, function () {
    console.log('Listening on port ', port)
})
