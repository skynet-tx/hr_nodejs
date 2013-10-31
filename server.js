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
    query_model = require('app_models/query_model.js');

// Config
app.configure(function () {
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    app.use(express.static(path.join(__dirname, "public")));
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

/**
 * Get positions
 */
app.get('/positions-list', function (req, res) {
    query_model.getPositions(req, res);
});
/**
 * Add new position
 */
app.post('/position', function (req, res) {
    query_model.setPosition(req, res);
});
/**
 * Delete position
 */
app.delete('/position/:id', function (req, res) {
    query_model.deletePosition(req, res);
});
/**
 * Get Departments list
 */
app.get('/departments-list', function (req, res) {
    query_model.getDepartments(req, res);
});


app.listen(port, function () {
    console.log('Server is ready. Listening on port ', port)
})
