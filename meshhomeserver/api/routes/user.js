const express = require("express");
const router = express.Router();

const UserController = require('../controllers/user');
const checkAuth = require('../middleware/check-auth');

router.post("/signup", UserController.user_signup);
router.post("/verifycode", UserController.user_verify_code);
router.post("/login", UserController.user_login);


// with auth
router.post("/refresh_token", checkAuth, UserController.user_refresh_token);
router.delete("/:userId", checkAuth, UserController.user_delete);

module.exports = router;
