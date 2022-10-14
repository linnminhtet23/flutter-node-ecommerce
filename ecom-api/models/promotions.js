const mongoose = require("mongoose");
const schema = mongoose.Schema;

const promotionSchema = new schema(
  {
    name: {
      type: String,
      require: true,
    },
    image: {
      type: String,
      default: "",
    },
  },
  { timestamps: true }
);

promotionSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

promotionSchema.set("toJSON", {
  virtuals: true,
});

Promotions = mongoose.model("Promotions", promotionSchema);
module.exports = Promotions;
