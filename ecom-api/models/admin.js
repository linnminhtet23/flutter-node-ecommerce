const mongoose = require("mongoose");
const schema = mongoose.Schema;

const adminSchema = new schema(
  {
    name: {
      type: String,
      require: true,
    },
    role: {
      type: String,
      require: true,
    },
    password: {
      type: String,
      require: true,
    },
    tokens: [
      {
        token: {
          type: String,
          required: true,
        },
      },
    ],
  },
  { timestamps: true }
);

adminSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

adminSchema.set("toJSON",{
    virtual: true,
});

Admin = mongoose.model("Admin", adminSchema);
module.exports = Admin;
