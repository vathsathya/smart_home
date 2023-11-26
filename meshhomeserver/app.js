const express = require("express");
const app = express();
const morgan = require("morgan");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");
const config = require("./api/config/config");
const rateLimiterRedisMiddleware = require('./api/middleware/rateLimiterRedis');

const user_productsRoutes = require("./api/routes/user_products");
const productRoutes = require("./api/routes/products");
const orderRoutes = require("./api/routes/orders");
const userRoutes = require('./api/routes/user');
const logRoutes = require('./api/routes/log');


app.use(rateLimiterRedisMiddleware);
// Connecting to the database
mongoose.Promise = global.Promise;
mongoose.connect(
  config.mongodbUrl
  , {
    useNewUrlParser: true,
        useUnifiedTopology: true,
        useCreateIndex: true,
  }).then(() => {
    console.log("Successfully connected to the database");
  }).catch(err => {
    console.log('Could not connect to the database. Exiting now...', err);
    process.exit();
  });
app.use(morgan("dev"));
app.use('/uploads', express.static('uploads'));
app.use('/fw', express.static('fw'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept, Authorization"
  );
  if (req.method === "OPTIONS") {
    res.header("Access-Control-Allow-Methods", "PUT, POST, PATCH, DELETE, GET");
    return res.status(200).json({});
  }
  next();
});

// Routes which should handle requests
app.use("/user_products", user_productsRoutes);
app.use("/products", productRoutes);
app.use("/orders", orderRoutes);
app.use("/user", userRoutes);
app.use("/log", logRoutes);

app.use((req, res, next) => {
  const error = new Error("Not found");
  error.status = 404;
  next(error);
});

app.use((error, req, res, next) => {
  res.status(error.status || 500);
  res.json({
    error: {
      message: error.message
    }
  });
});

require("./api/controllers/mqtt");

module.exports = app;
