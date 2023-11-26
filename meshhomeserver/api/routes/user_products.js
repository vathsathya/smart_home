const express = require("express");
const router = express.Router();
// const multer = require('multer');
const checkAuth = require('../middleware/check-auth');
const UserProductsController = require('../controllers/user_products');


router.get("/:userId/", checkAuth, UserProductsController.user_list_products);

router.post("/:userId/", checkAuth, UserProductsController.user_add_product);

router.get("/:userId/:productId", checkAuth, UserProductsController.user_get_product);

router.patch("/:userId/:productId", checkAuth, UserProductsController.products_update_product);

router.delete("/:userId/:productId", checkAuth, UserProductsController.products_delete);

module.exports = router;
