const mqtt = require('mqtt');
const mongoose = require("mongoose");
const client = mqtt.connect("mqtt://" + process.env.MQTT_SERVER + ":" + process.env.MQTT_SERVER_PORT, {
    clientId: process.env.MQTT_IDENT,
    qos: 2,
    clean: true,
    username: process.env.MQTT_USERNAME,
    password: process.env.MQTT_PASSWORD
});

const Product = require("../models/product");
const Log = require("../models/log");

// Publish Notification
const FCM = require('fcm-node');
const serverKey = require('../../meshhome-d0009-firebase-adminsdk-ngyn1-d933b0b5a1.json'); //put the generated private key path here
const fcm = new FCM(serverKey);

console.log("start of mqtt script");
console.log("connected flag  " + client.connected);

let serverStarted = false;

//handle incoming messages
client.on('message', async function(topic, message, packet) {

    // console.log('<topic: ' + topic + ' ----- message: ' + message + '>');

    var products = await Product.find({}).exec();
    for (product of products) {
        if (product.info.type == "switch") {
            var obj;


            try {
                obj = JSON.parse(message);
            } catch (e) {
                return;
            }

            // if (obj.sentBy == null || obj.sentBy == "undefined") return;

            var logmsg = '';

            // get topic from Commands
            if (topic == 'meshhome/' + product.serialNumber + '/commands') {
                if (obj.ledIndicator) {
                    logmsg = obj.sentBy + ' changed LED indicator to ' + obj.ledIndicator.toUpperCase();
                } else if (obj.ledIndicator) {
                    logmsg = obj.sentBy + ' changed LED indicator to ' + obj.ledIndicator.toUpperCase();
                } else if (obj.channel) {
                    logmsg = 'channel ' + obj.channel + ' is trigger ' + obj.state + ' by ' + obj.sentBy;
                }
            }

            if (topic == 'meshhome/' + product.serialNumber + '/state/1') {
                // console.log(product)
                Product.updateOne({
                    '_id': product._id,
                    'channels.channelIndex': obj.channel
                }, {
                    $set: {
                        'channels.$.value': obj.state
                    }
                }).exec();
                logmsg = 'channel ' + obj.channel + ' is trigger ' + obj.state + ' by ' + obj.sentBy;
            }
            if (topic == 'meshhome/' + product.serialNumber + '/state/2') {
                Product.updateOne({
                    '_id': product._id,
                    'channels.channelIndex': obj.channel
                }, {
                    $set: {
                        'channels.$.value': obj.state
                    }
                }).exec();
                logmsg = 'channel ' + obj.channel + ' is trigger ' + obj.state + ' by ' + obj.sentBy;

            }
            if (topic == 'meshhome/' + product.serialNumber + '/state/3') {

            }
            if (topic == 'meshhome/' + product.serialNumber + '/state/4') {

            }

            if (logmsg.length > 0) {
                if (serverStarted == true) {

                    logmsg.trim();
                    const log = new Log({
                        _id: new mongoose.Types.ObjectId(),
                        product: product._id,
                        trigger: obj.state,
                        sentBy: obj.sentBy,
                        log: logmsg
                    });
                    log.save();
                    logmsg = '';
                }
            }

        } else if (product.info.type == "door") {
            console.log('door: ' + message);
        } else if (product.info.type == "alarm") {
            console.log('alarm: ' + message);
        }

    }
    // console.log("topic is " + topic + " <--> " + message);
    if (client.connected) {
        serverStarted = true;
    }

});


client.on("connect", async function(e) {


    try {
        console.log("connected  " + client.connected);
        var products = await Product.find({}).exec();
        var topics = [];
        for (product of products) {
            topics.push('meshhome/' + product.serialNumber + '/status');
            // topics.push('meshhome/' + product.serialNumber + '/info');
            topics.push('meshhome/' + product.serialNumber + '/commands');
            topics.push('meshhome/' + product.serialNumber + '/state/#');
            // for (var i = 0; i < product.channels.length; i++) {
            //     topics.push('meshhome/' + product.serialNumber + '/state/' + product.channels[i].channelIndex);
            // }
        }    
        client.subscribe(topics, {
            qos: 2
        }); //topic list
    } catch (e) {
        return;
    }


});
//handle errors
client.on("error", function(error) {
    console.log("Can't connect" + error);
    process.exit(1)
});
//publish
function publish(topic, msg, options) {
    console.log("publishing", msg);

    if (client.connected == true) {

        client.publish(topic, msg, options);

    }
    count += 1;
    if (count == 2) //ens script
        clearTimeout(timer_id); //stop timer
    client.end();
}

//////////////

var options = {
    retain: true,
    qos: 1
};

//notice this is printed even before we connect
console.log("end of mqtt script");