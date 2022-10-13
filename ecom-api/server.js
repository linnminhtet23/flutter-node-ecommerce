const express = require("express");
const { default: mongoose } = require("mongoose");
const morgan = require("morgan");
const app = express();
const errorHandler = require("./helpers/errorHandler");
const listEndpoints = require("express-list-endpoints");

const userRouter = require("./routes/userRoute");
require("dotenv").config();
const router = express.Router();

const PORT = process.env.PORT || 3000;
const api = process.env.API_URL;

//middlewares
app.use(express.json());
app.use(morgan("dev"));
app.use(errorHandler);

//testing route
// app.use("/",(req,res)=>{
//     res.send("This is a testing server")
// })

//routes
app.use(`${api}user`, userRouter);

//get all route
if (app.get("env") === "development") {
  app.use(
    `${api}routes`,
    router.get("/", (req, res) => {
      // let route,
      //   routes = [];
      // app._router.stack.forEach(function (middleware) {
      //   if (middleware.route) {
      //     // routes registered directly on the app
      //     routes.push(middleware.route);
      //   } else if (middleware.name === "router") {
      //     // router middleware
      //     middleware.handle.stack.forEach(function (handler) {
      //       route = handler.route;
      //       route && routes.push(route);
      //     });
      //     // res.json("Hello")
      //   }
      // });
      res.json(listEndpoints(app));
    })
  );
}

app.listen(PORT, () => {
  mongoose.connect("mongodb://localhost:27017/ecommerce").then(() => {
    console.log("Database Connected");
    console.log(`server is up and running on port ${PORT}`);
  });
});
