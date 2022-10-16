const { body } = require("express-validator");
const signUpSchema = [
  body("name")
    .exists({ checkFalsy: null })
    .withMessage("Please fill your name"),
  body("role")
    .exists({ checkFalsy: null })
    .withMessage("Please fill your role"),
];

module.exports = signUpSchema;
