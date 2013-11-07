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
    app.use(express.static(path.join(__dirname, "public")));
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));

    app.use(express.cookieParser());
    app.use(express.cookieSession({secret : 'My super password'}));
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
 * Update position
 */
app.put('/position/:id', function (req, res) {
    query_model.updatePosition(req, res);
});
/**
 * Get Departments list
 */
app.get('/departments-list', function (req, res) {
    query_model.getDepartments(req, res);
});
/**
 * Add new Department
 */
app.post('/department', function (req, res) {
    query_model.setDepartment(req, res);
});
/**
 * Delete Department
 */
app.delete('/department/:id', function (req, res) {
    query_model.deleteDepartment(req, res);
});
/**
 * Update Department
 */
app.put('/department/:id', function (req, res) {
    query_model.updateDepartment(req, res);
});
/**
 * Get Staff list
 */
app.get('/staff-list', function (req, res) {
   query_model.getStaff(req, res);
});
/**
 * Add new Employee
 */
app.post('/employee', function (req, res) {
    query_model.setEmployee(req, res);
});
/**
 * Delete Employee
 */
app.delete('/employee/:id', function (req, res) {
    query_model.deleteEmployee(req, res);
});
/**
 * Update Department
 */
app.put('/employee/:id', function (req, res) {
    query_model.updateEmployee(req, res);
});

/**
 *  Returns two arrays
 *  Departments
 *  Positions
 */
app.get('/add-edit-employee', function(req, res){
    query_model.getAddEditEmployeeData(req, res);
});

/**
 * Check app on user exists
 */
app.get('/check-app', function(req, res){
    res.setHeader('Content-Type', 'application/json');
    res.send({isLoggin: req.session.email, authorizedAs: req.session.success });
});

app.post('/check-app', function(req, res){
    req.session = null;
    res.setHeader('Content-Type', 'application/json');
    res.send({success: true});
});

/**
 * Login
 */

var auth = require('app_controllers/authController.js');

app.get('/logout', function(req, res){
    // destroy the user's session to log them out
    // will be re-created next request
    req.session.destroy(function(){
        res.redirect('/#login');
    });
});


app.post('/login-page', function(req, res){
    auth.authenticate(req.body.email, req.body.password, function(err, user){
        if (user) {
            // Regenerate session when signing in
            // to prevent fixation
            req.session.email = user.email;
            req.session.success = 'Authenticated as ' + user.email;

            res.setHeader('Content-Type', 'application/json');
            res.send({success: true});

        } else {
            res.setHeader('Content-Type', 'application/json');
            res.send({success: false});
        }
    });
});


app.listen(port, function () {
    console.log('Server is ready. Listening on port ', port)
})
