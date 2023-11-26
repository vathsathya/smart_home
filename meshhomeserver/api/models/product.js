const mongoose = require("mongoose");

const productSchema = mongoose.Schema(
  {
    _id: mongoose.Schema.Types.ObjectId,
    serialNumber: { type: "String", required: true, unique: true },
    info: {
      name: { type: "String", required: true },
      model: { type: "String" },
      type: { type: "String" },
    },
    channels: { type: ["Mixed"] },
    automation: { type: ["Mixed"] },
  },
  { timestamps: true, versionKey: false }
);

module.exports = mongoose.model("Product", productSchema);
