const mongoose = require('mongoose');

const firebaseTokenSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    userId: {
        type: String,
        required: true,
    },
    firebasetoken: {
        type: String,
        required: true,
        unique: true,
    }
},{ versionKey: false });

module.exports = mongoose.model('FirebaseToken', firebaseTokenSchema);
