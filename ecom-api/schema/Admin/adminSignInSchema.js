const { body } = require("express-validator");

const signInSchema = [
  body("email").isEmail().withMessage("Wrong email and password"),
  body("password").isLength({ min: 6 }).withMessage("Wrong email and password"),
];

module.exports = signInSchema;
