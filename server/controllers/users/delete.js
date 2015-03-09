var bodyParser = require('body-parser').json();

module.exports = function(app){
    app.server.delete('/user/:id',

        function removeUser(req, res) {
			app.models.User.findById(req.params.id, function(err, user) {
				if (err) {
					res.status(500).send(err.toString());
					return;
				} else if (!user) {
					res.status(404).send("User not found");
					return;
				} else {
					app.models.User.remove({ id_user:req.params.id }, onUserRemoved);

					function onUserRemoved(err, removed) {
						if (err) {
							res.status(500).send(err.toString());
							return;
						} else {
							res.status(200).send("User removed with success");
						}
					}
				}
			});
		});
};