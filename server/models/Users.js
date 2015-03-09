module.exports = function(app){
    var UserSchema = app.mongoose.Schema({
        name_user: {
            type: String,
            required: true
        },
        mail_user: {
            type: String,
            required: true
        },
        pass_user: {
            type: String,
            required: true
        },
        device_user: {
            type: Number
        }
    });

    UserSchema.index({mail_user: 1}, {unique: true});

    UserSchema.methods.toJSON = function() {
        var user = this.toObject();
        delete user.pass_user;
        return user;
    };

    return app.mongoose.model('User', UserSchema);
};