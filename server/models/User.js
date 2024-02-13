const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
    username : {
        type:String, 
        required:true, 
        max : 255, 
    }, 
    password : {
        type: String, 
        required : true, 
        max : 255, 
        min : 6
    }
});

module.exports = mongoose.model('User', UserSchema);