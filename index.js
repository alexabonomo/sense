var mqtt = require('mqtt');
var client = mqtt.connect('mqtt://10.1.6.159');
//import express
var express = require('express');
//create express object named app
var app = express();

//instantiate a server on port 3000
var server = app.listen(3000);
var io = require('socket.io')(server);

let accel;

io.on('connection', function(socket){
  console.log('a user connected');
});

//expose the local public folder for inluding files js, css etc..
app.use(express.static('public'));

//on a request to / serve index.html
app.get('/', function(req, res) {
    res.sendFile(__dirname + '/index.html');
});


client.on('connect', function() {
          client.subscribe('accel');

    // client.publish('/hello', 'Hello mqtt');
});

client.on('message', function(topic, message) {
    // message is Buffer

    d = message.toString().split(",");
    accel = {x: d[0], y: d[1], z: d[2]}
    console.log("accel is: ", accel);
    io.sockets.emit('data', accel
    );
  });
