module.exports = {
    apps: [{
            name: "meshhomeserver",
            script: "index.js",
            watch: true,
            ignore_watch: ["[\\/\\\\]\\./", "node_modules"],
            exec_interpreter: "node",
            exec_mode: "fork",
            env: {
                NODE_ENV: "development",
                MQTT_SERVER: "localhost",
                MQTT_SERVER_PORT: "1883",
                MQTT_IDENT: "mqttserver_online",
                MQTT_USERNAME: "meshhome",
                MQTT_PASSWORD: "Bongthom.net1",
                MONGO_DB_SERVER: "localhost",
                MONGO_DB_USER: "meshhomedb",
                MONGO_DB_PW: "dade562eeb0a7edae60df2297b2ff8c3183c107c",
                PORT: "8080",
                JWT_KEY: "secret"
            },
            env_production: {
                NODE_ENV: "production",
                MQTT_SERVER: "localhost",
                MQTT_SERVER_PORT: "1883",
                MQTT_IDENT: "mqttserver_online",
                MQTT_USERNAME: "meshhome",
                MQTT_PASSWORD: "Bongthom.net1",
                MONGO_DB_SERVER: "localhost",
                MONGO_DB_USER: "meshhomedb",
                MONGO_DB_PW: "dade562eeb0a7edae60df2297b2ff8c3183c107c",
                PORT: "8080",
                JWT_KEY: "secret"
            },
            max_memory_restart: '300M'
        }
    ]
}
