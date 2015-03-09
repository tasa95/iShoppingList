var bodyParser = require('body-parser').json();
var sha1 = require('sha1');

module.exports = function(app) {
    app.server.put('/list/:id',
        bodyParser,

        function updateList(req, res) {
			var datas = {};

			if (req.body.name_list)
				datas.name_list = req.body.name_list;
			
			app.models.List.findById(req.params.id, function(err, list) {
				if (err) {
					res.status(500).send(err.toString());
					return;
				} else if (!list) {
					res.status(404).send("List not found");
					return;
				} else {
					app.models.List.update({ id_list:req.params.id },
						{
							$set: datas
						}, 
						onListUpdated);

					function onListUpdated(err, updated) {
						if (err) {
							res.status(500).send(err.toString());
							return;
						} else {
							res.status(200).send(list.toJSON());
						}
					}
				}
			});
		});
};