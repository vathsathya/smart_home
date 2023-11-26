module.exports = {    
    mongodbUrl: 'mongodb://' + process.env.MONGO_DB_USER + ':' + process.env.MONGO_DB_PW + '@' + process.env.MONGO_DB_SERVER + ':27017/meshhomedb?gssapiServiceName=mongodb',    
}