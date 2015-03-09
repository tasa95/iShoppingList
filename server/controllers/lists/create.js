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
			list.id_user = req.body.id_user;
			// list.id_user = req.session.userId;   <=== get user session 

			list = new app.models.List(list);
			list.save(onListCreated);

			function onListCreated(err, list){
				if (err) {
					res.status(500).send(err.toString());
				} else {
					var items = req.body.items;

					for (i=0; i<items.length; i++) {
						var item = {};
						item.text_item = items[i].text_item;
						item.nb_item = items[i].nb_item;

						itemModel = new app.models.Item(item);
						itemModel.save(function(err, saved) {
							if (err) {
								res.status(500).send("An error occurred in items creation: "+err.toString());
							} else if (saved && i == items.length-1) {
								res.status(200).send("The list is well created");
							}
						});
					}
				}
			}
		});
};