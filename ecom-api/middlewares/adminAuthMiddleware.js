const jwt = require("jsonwebtoken");
const Admin = require("../models/admins");
const adminAuthMiddleware = async (req, res, next) => {
  try {
    const token = req.header("Authorization").split(" ")[1];
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    const admin = await Admin.findOne({
      id: decoded.id,
      "tokens.token": token,
    });
    if (!admin) {
      throw new Error();
    }

    req.admin = admin;
    req.token = token;
    next();
  } catch (error) {
    res.status(400).send("You are not authorized to access this endpoint");
  }
};

module.exports = adminAuthMiddleware;
