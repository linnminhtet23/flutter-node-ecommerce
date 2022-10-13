function errorHandler(error, req, res, next) {
  if (error.name === "UnauthorizedError") {
    //jwt authentication error
    return res.status(401).json({ message: "this user is not authorized" });
  }

  if (error.name === "ValidationError") {
    // validation error
    return res.status(401).json({ message: err });
  }


  //default
  return res.status(500).json(err);
}

module.exports = errorHandler;