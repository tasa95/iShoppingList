module.exports = function(app){
    require('./users')(app);
    require('./lists')(app);
};