const mongoose = require("mongoose");
const Product = require("../models/product");
const UserProduct = require("../models/user_product");
const User = require("../models/user");

exports.user_list_products = (req, res, next) => {
    UserProduct.find({ user: req.params.userId })
        .select('-_id userType')
        .populate('product')
        .exec()
        .then(docs => {
            res.status(200).json({
                count: docs.length,
                products: docs
            });
        })
        .catch(err => {
            console.log(err);
            res.status(500).json({
                error: err
            });
        });
};

exports.user_add_product = (req, res, next) => {
    User.find({ _id: req.params.userId })
        .select("_id")
        .exec()
        .then(user => {
            if (user.length > 0) {
                Product.find({ serialNumber: req.body.serialNumber })
                    .select("_id serialNumber")
                    .exec()
                    .then(product => {
                        if (product.length > 0) {
                            query = {
                                $and: [
                                    { user: user[0]._id },
                                    { product: product[0]._id }
                                ]
                            }
                            UserProduct.find(query)
                                .exec()
                                .then(result => {
                                    if (result.length <= 0) {
                                        UserProduct({
                                                user: mongoose.Types.ObjectId(user[0]._id),
                                                product: mongoose.Types.ObjectId(product[0]._id),
                                            }).save()
                                            .then(result => {
                                                res.status(500).json({
                                                    message: "product saved!"
                                                });
                                            })
                                            .catch(err => {
                                                console.log(err);
                                                res.status(500).json({
                                                    error: err
                                                });
                                            });
                                    } else {
                                        res.status(500).json({
                                            error: "product existed!"
                                        });
                                    }
                                });

                        } else {
                            res.status(500).json({
                                error: "product not found!"
                            });
                        }
                    })
                    .catch(err => {
                        console.log(err);
                        res.status(500).json({
                            error: err
                        });
                    });
            } else {
                res.status(500).json({
                    error: "user not found!"
                });
            }
        })
        .catch(err => {
            console.log(err);
            res.status(500).json({
                error: err
            });
        });
};

exports.user_get_product = (req, res, next) => {
    res.status(200).json(req.body);
    // const id = req.params.productId;
    // Product.findById(id)
    //     // .select("name price _id ")
    //     .exec()
    //     .then(doc => {
    //         console.log("From database", doc);
    //         if (doc) {
    //             res.status(200).json({
    //                 product: doc,
    //                 request: {
    //                     type: "GET",
    //                     url: "http://localhost:8080/products"
    //                 }
    //             });
    //         } else {
    //             res
    //                 .status(404)
    //                 .json({ message: "No valid entry found for provided ID" });
    //         }
    //     })
    //     .catch(err => {
    //         console.log(err);
    //         res.status(500).json({ error: err });
    //     });
};

exports.products_update_product = (req, res, next) => {
    const id = req.params.productId;
    const updateOps = {};
    for (const ops of req.body) {
        updateOps[ops.propName] = ops.value;
    }
    Product.update({ _id: id }, { $set: updateOps })
        .exec()
        .then(result => {
            res.status(200).json({
                message: "Product updated",
                request: {
                    type: "GET",
                    url: "http://localhost:8080/products/" + id
                }
            });
        })
        .catch(err => {
            console.log(err);
            res.status(500).json({
                error: err
            });
        });
};

exports.products_delete = (req, res, next) => {

    var query = {
        $and: [
            { user: req.params.userId },
            { product: req.params.productId }
        ]
    };
    UserProduct.find(query)
        .exec()
        .then(userproduct => {
            UserProduct
                .remove({ "_id": userproduct[0]._id })
                .then(result => {
                    if(result.deletedCount === 1){
                        res.status(200).json({ message: "Remove successful!" });
                    }
                })
                .catch(err => {
                    console.log(err);
                    res.status(500).json({
                        error: err
                    });
                });
        })
        .catch(err => {
            console.log(err);
            res.status(500).json({
                error: err
            });
        });
};