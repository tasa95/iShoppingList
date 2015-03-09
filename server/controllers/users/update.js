var bodyParser = require('body-parser').json();
var sha1 = require('sha1');

module.exports = function(app) {
    app.server.put('/user/:id',
        bodyParser,

        function updateUser(req, res) {
			var datas = {};

			if (req.body.name_user)
				datas.name_user = req.body.name_user;
			if (req.body.mail_user)
				datas.mail_user = req.body.mail_user;
			if (req.body.pass_user)
				datas.pass_user = sha1(req.body.pass_user);
			if (req.body.device_user)
				datas.device_user = req.body.device_user;
			
			app.models.User.findById(req.params.id, function(err, user) {
				if (err) {
					res.status(500).send(err.toString());
					return;
				} else if (!user) {
					res.status(404).send("User not found");
					return;
				} else {
					app.models.User.update({ id_user:req.params.id },
						{
							$set: datas
						}, 
						onUserUpdated);

					function onUserUpdated(err, updated) {
						if (err) {
							res.status(500).send(err.toString());
							return;
						} else {
							res.send(user.toJSON());
						}
					}
				}
			});
		});
};