const mongoose = require('mongoose');

const logSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    product: { type: mongoose.Schema.Types.ObjectId, ref: 'Product', required: true },
    sentby: { type: String },
    trigger: { type: String },
    log: { type: String }
},{ timestamps: true,versionKey: false });

module.exports = mongoose.model('Log', logSchema);
