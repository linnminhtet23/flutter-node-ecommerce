const { body } = require("express-validator");
const signUpSchema = [
  body("name")
    .exists({ checkFalsy: null })
    .withMessage("Please fill your name"),
  body("email")
    .exists({ checkFalsy: null })
    .isEmail()
    .withMessage("Please fill your email"),
  body("password")
    .isLength({ min: 6 })
    .withMessage("Password must be at least 6 characters"),
  body("confirmPassword").custom((value, { req }) => {
    // console.log({value, pw: req.body.password});
    if (value !== req.body.password) {
      throw new Error("Password should be match");
    }
    return true;
  }),
  body("phone").isMobilePhone().withMessage("Please fill your valid number"),
];

module.exports = signUpSchema;
