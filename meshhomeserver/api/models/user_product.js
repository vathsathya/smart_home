const mongoose = require('mongoose');

const userProductSchema = mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: 'User'
    },
    product: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: 'Product'
    },
    userType: {
        type: 'String',
        required: true,
        default: 'owner'
    },
}, {
    timestamps: true,
    versionKey: false
});

module.exports = mongoose.model('UserProduct', userProductSchema);


// User type
// 1. owner
// 2. shared