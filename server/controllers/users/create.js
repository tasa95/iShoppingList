var bodyParser = require('body-parser').json();
var sha1 = require('sha1');

module.exports = function(app) {
	app.server.post('/signup',
		bodyParser,
		function userAlreadyExist(req, res, next) {
			app.models.User.findOne({ mail_user: req.body.mail_user }, function(err, user) {
				if (err) {
              		res.status(500).send(err.toString());
          			return;
           		} else if(user) {
           			res.status(403).send("This email or this login already exists");
          			return;
        		} else
					next();
			});
		},
		
		function ensureRequiredFields(req, res, next) {
			if (!req.body.name_user || !req.body.mail_user || !req.body.pass_user) {
				res.status(403).send("Missing required field");
				return;
			} else
				next();
		},

		function createUser(req, res) {
			var user = {};
			user.name_user = req.body.name_user;
			user.mail_user = req.body.mail_user;
			user.pass_user = sha1(req.body.pass_user);

			if (req.body.device_user)
				user.device_user = req.body.device_user;

			user = new app.models.User(user);
			user.save(onUserCreated);

			function onUserCreated(err, user){
				if (err) {
					res.status(500).send(err.toString());
				} else {
					res.status(200).send(user.toJSON());
				}
			}
		});
};