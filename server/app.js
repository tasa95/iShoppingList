var express = require('express');
var http = require('http');

(function init(){
    var exp = express();
    var app = http.createServer(exp);

    require('./settings')(app);
    require('./models')(app);
    require('./controllers')(app);

    app.listen(app.settings.port);
}());