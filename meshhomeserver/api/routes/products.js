const express = require("express");
const router = express.Router();
// const multer = require('multer');
const checkAuth = require('../middleware/check-auth');
const ProductsController = require('../controllers/products');


router.get("/", checkAuth, ProductsController.products_get_all);

router.post("/", checkAuth, ProductsController.products_create_product);

router.get("/:productId", checkAuth, ProductsController.products_get_product);

router.patch("/:productId", checkAuth, ProductsController.products_update_product);

router.delete("/:productId", checkAuth, ProductsController.products_delete);

module.exports = router;
