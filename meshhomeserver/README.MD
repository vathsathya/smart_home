# Creating a RESTful API with Node.js
This repository accompanies my YouTube video series on building a RESTful API with Node.js: [https://github.com/academind/node-restful-api-tutorial.git](https://github.com/academind/node-restful-api-tutorial.git)

## Usage
Check out the branch you're interested in (i.e. which belongs to the video in my series you just watched), ```git clone``` it and thereafter run ```npm install```.

Make sure to also add your Mongo Atlas Admin Username to a nodemon.json file (which you have to create).

```
How to install projects

1. First remove Depencies, and devDependencies

2. Install 
npm install bcrypt body-parser express jsonwebtoken mongoose morgan multer --save
npm install -g nodemon
npm install --save-dev nodemon

{
    "env": {
        "MONGO_ATLAS_PW": "YOUR_MONGO_USER_PW"
    }
}


## API

I. User 
    1. Signup
        POST http://localhost:8080/user/signup
        params
        {
            "username": "phatsreynich",
            "firstname": "Phat",
            "lastname": "Sreynich",
            "email": "phat.sreynich@gmail.com",
            "phone_number": "010298188",
            "password": "Nichnich"
        }
    1. Login
        POST http://localhost:8080/user/login
        params
        {            
            email: "vath.sathya@gmail.com",
            password: "Vathsathya123"
        }
        
II. Product
    1. Add Product
        POST http://localhost:8080/products/
        params
        {
            "serialNumber": "mtsw-3133244",
            "info": {
                "name": "mtsw-3133244",
                "model": "SW002",
                "type": "switch"
            },
            "channels": [
                {
                    "channelIndex": "1",
                    "channelName":"Channel 1",
                    "topic": "meshhome/mtsw-3133244/state/1",
                    "value": "on"
                },
                {
                    "channelIndex": "2",
                    "channelName":"Channel 2",
                    "topic": "meshhome/mtsw-3133244/state/2",
                    "value": "off"
                }
            ],
            "automation": [
                {
                    "startTime": "00:00:00",
                    "trigger": [
                        {
                            "topic": "meshhome/MT00000100/channels/0",
                            "value": 0
                        }
                    ]
                }
            ]
        }
III. User Products
    1. Add Product to user
    POST http://192.168.0.10:8080/user_products/{userId}/
    params 
    {
        "serialNumber": "MT00000116"
    }

    2. Delete Product from User
    DELETE http://192.168.10.10:8080/user_products/{userId}/{productId}

```
