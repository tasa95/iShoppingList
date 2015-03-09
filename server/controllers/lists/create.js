var bodyParser = require('body-parser').json();
var sha1 = require('sha1');

module.exports = function(app) {
	app.server.post('/list',
		bodyParser,
		
		function ensureRequiredFields(req, res, next) {
			if (!req.body.name_list) {
				res.status(403).send("Missing required field");
				return;
			} else
				next();
		},

		function createList(req, res) {
			var list = {};
			list.name_list = req.body.name_list;
			list.user_id = req.body.user_id;
			// list.id_user = req.session.userId;   <=== get user session 

			list = new app.models.List(list);
			list.save(onListCreated);

			function onListCreated(err, list){
				if (err) {
					res.status(500).send(err.toString());
				} else {
					res.status(200).send(list.toJSON());
				}
			}
		});
};