module.exports = function(app){
    var ItemSchema = app.mongoose.Schema({
        text_item: {
            type: String,
            required: true
        },
        id_list:{
            type: app.mongoose.Schema.Types.ObjectId,
            ref: 'List',
            required: true
        },
        status_item: {
            type: String,
            required: true,
            default: 'unchecked',
            enum: ['unchecked', 'checked']
        },
        created_date_item : {
            type : Date,
            default : Date.now
        },
        updated_date_item : {
            type : Date,
            default : Date.now
        }
    });

    return app.mongoose.model('Item', ItemSchema);
};