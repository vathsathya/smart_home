const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    email: {
        type: String,
        required: true,
        unique: true,
        match: /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    },
    phone_number: { 
        type: String,
        required: true 
    },
    username: {
        type: String,
        require: true,
        unique: true
    },
    firstname: {
        type: String,
    },
    lastname: {
        type: String,
    },
    password: { 
        type: String, 
        required: true 
    },
    verifyCode: {
        type: String, 
    },
    isActivated: {
        type: Boolean,
        default: false
    }
}, {
    timestamps: true,
    versionKey: false
});

module.exports = mongoose.model('User', userSchema);