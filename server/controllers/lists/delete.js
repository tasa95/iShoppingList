var bodyParser = require('body-parser').json();

module.exports = function(app) {
    app.server.delete('/list/:id',

        function removeUser(req, res) {
			app.models.List.findById(req.params.id, function(err, user) {
				if (err) {
					res.status(500).send(err.toString());
					return;
				} else if (!user) {
					res.status(404).send("List not found");
					return;
				} else {
					app.models.List.remove({ id_list: req.params.id }, onListRemoved);

					function onListRemoved(err, removed) {
						if (err) {
							res.status(500).send(err.toString());
							return;
						} else {
							app.models.Item.remove({ id_list: req.params.id }, onItemsRemoved);

							function onListRemoved(err, removed) {
								if (err) {
									res.status(500).send(err.toString());
									return;
								} else {
									res.status(200).send("List removed with success");
								}
							}
						}
					}
				}
			});
		});
};