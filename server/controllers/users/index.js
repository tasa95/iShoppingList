module.exports = function(app){
    require('./create')(app);
    require('./delete')(app);
    require('./show')(app);
    require('./update')(app);
};