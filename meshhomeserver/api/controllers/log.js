const mongoose = require("mongoose");
const moment = require('moment-timezone');

const Log = require("../models/log");
const User = require("../models/user");

exports.log_query = (req, res, next) => {
    const perPage = 20; // results per page
    const page = Math.max(0, req.params.page); // Page   

    Log.find({
            product: req.params.device
        })
        .select('_id trigger product log createdAt')
        .limit(perPage)
        .skip((perPage * page) - perPage)
        .sort({
            createdAt: 'desc'
        })
        .exec(function(err, logs) {
            if (!err) {
                const logsDocument = logs.map((data) =>{
                    return {
                        _id: data._id,
                        trigger: data.trigger,
                        product: data.product,
                        log: data.log,
                        createdAt: new moment(data.createdAt).tz('Asia/Phnom_Penh').format()


                    }
                });

                res.status(200).json([{
                    page: page,
                    pages: (logsDocument.length / perPage),
                    total: logsDocument.length
                }, logsDocument]);

            } else {
                res.status(500).json({
                    error: err
                });
            }

        });
};