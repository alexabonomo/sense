var mqtt = require('mqtt');
var client = mqtt.connect('mqtt://10.0.0.50');
//import express
var express = require('express');
//create express object named app
var app = express();

//instantiate a server on port 3000
var server = app.listen(3000);
var io = require('socket.io')(server);

//expose the local public folder for inluding files js, css etc..
app.use(express.static('public'));

//on a request to / serve index.html
app.get('/', function(req, res) {
    res.sendFile(__dirname + '/index.html');
});


client.on('connect', function() {
    client.subscribe('accelx');
    // client.publish('/hello', 'Hello mqtt');
});

client.on('message', function(topic, message) {
    // message is Buffer
    x = message.toString()
    console.log(x);
    io.sockets.emit('data', {
        val: x
    });


});
