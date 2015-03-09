var express = require('express');

(function init(){
    var app = {
        server: express()
    };

    require('./settings')(app);
    require('./models')(app);
    require('./controllers')(app);

    app.server.listen(app.settings.port);
}());