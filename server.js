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
    app.use(express.cookieSession({secret: 'My super password'}));
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
    if(req.session.role !== "admin"){
        res.setHeader('Content-Type', 'application/json');
        res.send({success: false});
    } else{
        query_model.deletePosition(req, res);
    }
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
    if(req.session.role !== "admin"){
        res.setHeader('Content-Type', 'application/json');
        res.send({success: false});
    } else{
        query_model.deleteDepartment(req, res);
    }
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
    if(req.session.role !== "admin"){
        res.setHeader('Content-Type', 'application/json');
        res.send({success: false});
    } else{
        query_model.deleteEmployee(req, res);
    }
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
app.get('/add-edit-employee', function (req, res) {
    query_model.getAddEditEmployeeData(req, res);
});

/**
 * Get managers and Admins of app
 */
app.get('/adm/users-list', function (req, res) {
    if (req.session.role !== 'admin') {
        res.setHeader('Content-Type', 'application/json');
        res.send({success: false});
    } else {
        query_model.getUsers(req, res);
    }
});


/**
 * Check app on user exists
 */
app.get('/check-app', function (req, res) {
    res.setHeader("Set-Cookie", ["role=" + req.session.role + "", "language=javascript"]);
    res.setHeader('Content-Type', 'application/json');
    res.send({
        isLoggin: req.session.email,
        authorizedAs: req.session.success,
        role: req.session.role
//        role: 'manager'
    });
});

app.post('/check-app', function (req, res) {
    req.session = null;

    res.setHeader('Content-Type', 'application/json');
    res.send({success: true});
});

/**
 * Login
 */

var auth = require('app_controllers/authController.js');

app.get('/logout', function (req, res) {
    // destroy the user's session to log them out
    // will be re-created next request
    req.session.destroy(function () {
        res.redirect('/#login');
    });
});

/**
 * Login to the site
 */
app.post('/login-page', function (req, res) {
    auth.authenticate(req.body.email, req.body.password, function (err, user) {
        if (user) {
            // Regenerate session when signing in
            // to prevent fixation
            req.session.email = user.email;
            req.session.success = 'Authenticated as ' + user.email;
            req.session.role = user.role;

            res.setHeader('Content-Type', 'application/json');
            res.send({success: true});

        } else {
            res.setHeader('Content-Type', 'application/json');
            res.send({success: false});
        }
    });
});

/**
 * Add new manager or admin
 */
app.post('/adm/user', function (req, res) {
    auth.addNewUser(req.body, function (err, result) {
        if (result.success) {
            res.setHeader('Content-Type', 'application/json');
            res.send({success: true});
        } else {
            res.setHeader('Content-Type', 'application/json');
            res.send({success: false});
        }
    });
});

/**
 * Delete Manager or Admin
 */
app.delete('/adm/user/:id', function (req, res) {
    query_model.deleteManagerAdmin(req, res);
});
/**
 * Edit Admin or Manager record
 */
app.put('/adm/user/:id', function (req, res) {
    if(!req.body.password){
        query_model.updateUser(req, res);
    } else {
        auth.getCredentials(req.body.password, function (err, result) {
            if (err) {
                res.setHeader('Content-Type', 'application/json');
                res.send({success: false});
            } else {
                query_model.updateUser(req, res, result);
            }
        });
    }
});


app.listen(port, function () {
    console.log('Server is ready. Listening on port ', port)
})
