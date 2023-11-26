const express = require("express");
const router = express.Router();
const checkAuth = require('../middleware/check-auth');
const LogController = require('../controllers/log');

router.get("/:device/:page", checkAuth, LogController.log_query);

module.exports = router;
