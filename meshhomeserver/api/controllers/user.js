const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const User = require("../models/user");
const FirebaseToken = require("../models/firebasetoken");

function getRandomInt(number) {
    return Math.floor(100000 + Math.random() * 900000);
}
exports.user_signup = (req, res, next) => {

    User.find({
            email: req.body.email
        })
        .exec()
        .then(user => {
            if (user.length >= 1) {
                return res.status(409).json({
                    message_code: "mail_exists",
                    message: "Mail exists"
                });
            } else {
                var verifyCode = getRandomInt(6);
                bcrypt.hash(req.body.password, 10, (err, hash) => {
                    if (err) {
                        return res.status(500).json({
                            error: err
                        });
                    } else {
                        const user = new User(req.body);
                        user._id = new mongoose.Types.ObjectId();
                        user.password = hash;
                        user.verifyCode = verifyCode;
                        user.isActivated = false;
                        user
                            .save()
                            .then(result => {
                                console.log(result);
                                res.status(201).json({
                                    message_code: "user_created",
                                    message: "User created"
                                });
                            })
                            .catch(err => {
                                console.log(err);
                                res.status(500).json({
                                    message_code: "error",
                                    error: err
                                });
                            });
                    }
                });
            }
        });
};

exports.user_verify_code = (req, res, next) => {

    User.find({
            email: req.body.email
        })
        .exec()
        .then(user => {
            if (user.length < 1) {
                return res.status(401).json({
                    message_code: "auth_failed",
                    message: "Auth failed"
                });
            }
            if (req.body.verifyCode != user[0].verifyCode) {

                User.update({
                        _id: user[0]._id
                    }, {
                        $set: {
                            isActivated: true,
                            verifyCode: ""
                        }
                    })
                    .exec()
                    .then(result => {
                        return res.status(200).json({
                            message_code: "user_isactivated",
                            message: result,
                        });
                    })
                    .catch(err => {
                        console.log(err);
                        res.status(500).json({
                            error: err
                        });
                    });
            }
        })
        .catch(err => {
            console.log(err);
            res.status(500).json({
                error: err
            });
        });
}


exports.user_login = (req, res, next) => {
    const {email,password,firebasetoken} = req.body;

    User.find({
            email: email
        })
        .exec()
        .then(user => {
            if (user.length < 1) {
                return res.status(401).json({
                    message_code: "auth_failed",
                    message: "Auth failed"
                });
            }
            bcrypt.compare(password, user[0].password, (err, result) => {
                if (err) {
                    return res.status(401).json({
                        message_code: "auth_failed",
                        message: "Auth failed"
                    });
                }
                if (result) {
                    const token = jwt.sign({
                            email: user[0].email,
                            userId: user[0]._id
                        },
                        process.env.JWT_KEY, {
                            expiresIn: "360d"
                        }
                    );
                    FirebaseToken.find({
                            userId: user[0]._id
                        })
                        .exec()
                        .then(_token => {
                            if (_token.length < 1) {
                                const firebaseToken = new FirebaseToken({
                                    _id: new mongoose.Types.ObjectId(),
                                    firebasetoken: firebasetoken,
                                    userId: user[0]._id
                                });
                                firebaseToken.save();
                            }
                        });
                    return res.status(200).json({
                        message_code: "auth_successful",
                        message: "Auth successful!",
                        user: {
                            _id: user[0]._id,
                            isActivated: user[0].isActivated,
                            username: user[0].username,
                            firstname: user[0].firstname,
                            lastname: user[0].lastname,
                            email: user[0].email,
                            phone_number: user[0].phone_number,
                            createdAt: user[0].createdAt,
                            updatedAt: user[0].updatedAt
                        },
                        token: token
                    });
                }
                res.status(401).json({
                    message_code: "auth_failed",
                    message: "Auth failed"
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

exports.user_refresh_token = (req, res, next) => {
    User.find({
            email: req.body.email
        })
        .exec()
        .then(user => {
            if (user.length < 1) {
                return res.status(401).json({
                    message_code: "auth_failed",
                    message: "Auth failed"
                });
            } else {
                const token = jwt.sign({
                        email: user[0].email,
                        userId: user[0]._id
                    },
                    process.env.JWT_KEY, {
                        expiresIn: "360d"
                    }
                );
                return res.status(200).json({
                    message_code: "auth_successful",
                    message: "Auth successful!",
                    token: token
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

exports.user_delete = (req, res, next) => {
    User.remove({
            _id: req.params.userId
        })
        .exec()
        .then(result => {
            res.status(200).json({
                message_code: "user_deleted",
                message: "User deleted"
            });
        })
        .catch(err => {
            console.log(err);
            res.status(500).json({
                error: err
            });
        });
};