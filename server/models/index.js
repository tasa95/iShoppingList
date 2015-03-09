var mongoose = require('mongoose');

module.exports = function(app){
    app.mongoose = mongoose.connect(app.settings.url);

    app.models = {};
    app.models.User = require('./Users')(app);
    app.models.List = require('./Lists')(app);
    app.models.Item = require('./Items')(app);
};