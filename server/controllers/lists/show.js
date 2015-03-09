module.exports = function(app) {
    app.server.get('/list/:id',
        
        function(req, res) {
			app.models.List.findById(req.params.id, function(err, list) {
				if (err) {
					res.status(500).send(err.toString());
					return;
				} else if (!list) {
					res.status(404).send("List not found");
					return;
				} else {
					//res.status(200).send(list);

					// Retrieve all items related
					app.models.Item.
				}
			});
        });
};