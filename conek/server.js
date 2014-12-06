var http = require('http');
var dgram = require('dgram');

var server_port = process.env.OPENSHIFT_NODEJS_PORT || 8080
var server_ip_address = process.env.OPENSHIFT_NODEJS_IP || '127.0.0.1'

var last = "none";

var server = dgram.createSocket('udp4');

server.on("error", function (err) {
  console.log("server error:\n" + err.stack);
  server.close();
});

server.on("message", function (msg, rinfo) {
	var data = JSON.parse(msg)

	var message = new Buffer("thx for the "+msg);
	console.log("thx for the "+msg);
	var client = dgram.createSocket("udp4");
	client.send(message, 0, message.length, rinfo.port, rinfo.address, function(err, bytes) {
	  client.close();
	});
});

server.on("listening", function () {
	var address = server.address();
	console.log("server listening " +
	 	address.address + ":" + address.port);
});

server.bind(1337);