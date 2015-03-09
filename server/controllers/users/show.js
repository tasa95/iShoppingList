var sha1 = require('sha1');

module.exports = function(app){
    app.server.get('/user/:id',
        
        function(req, res){
			app.models.User.findById(req.params.id, function(err, user) {
				if (err) {
					res.status(500).send(err.toString());
					return;
				} else if (!user) {
					res.status(404).send("User not found");
					return;
				} else {
					res.status(200).send(user);
				}
			});
        });

    app.server.post('/login',
        
        function(req, res){
			app.models.User.find({ id_user: req.params.id, pass_user: sha1(req.params.pass_user) }, function(err, user) {
				if (err) {
					res.status(500).send(err.toString());
					return;
				} else if (!user) {
					res.status(404).send("User not found");
					return;
				} else {
					res.status(200).send(user);
				}
			});
        });
};