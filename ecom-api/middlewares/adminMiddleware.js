const adminMiddleware = async (req, res, next) => {
  if (req.admin && req.admin.role === "Developer") {
    next();
  } else if (req.admin.role === "Admin") {
    next();
  } else {
    res.sendStatus(401);
  }
};

module.exports = adminMiddleware;
