module.exports = function(app){
    var ListSchema = app.mongoose.Schema({
        name_list: {
            type: String,
            required: true
        },
        id_user:{
            type: app.mongoose.Schema.Types.ObjectId,
            ref: 'User',
            required: true
        }
    });

    return app.mongoose.model('List', ListSchema);
};