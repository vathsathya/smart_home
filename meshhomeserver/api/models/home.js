const mongoose = require("mongoose");

const homeSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    name: {
        type: "String",
        required: true,
        unique: true
    },
    floor: {
        type: ["Mixed"],
        required: true,
        unique: true
    },
    room: {
        type: ["Mixed"],
        required: true,
        unique: true
    }

}, {
    timestamps: true,
    versionKey: false
});

module.exports = mongoose.model("Home", homeSchema);