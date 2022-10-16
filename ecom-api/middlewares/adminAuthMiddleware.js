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
    res.sendStatus(401);
  }
};

module.exports = adminAuthMiddleware;
