var http = require('http');
var dgram = require('dgram');

var server_port = process.env.OPENSHIFT_NODEJS_PORT || 8080
var server_ip_address = process.env.OPENSHIFT_NODEJS_IP || '127.0.0.1'

var last = "none";

var server = dgram.createSocket('udp4', function(msg) {
	console.log(msg);
	last = msg;
});

server.on("error", function (err) {
  console.log("server error:\n" + err.stack);
  server.close();
});

server.on("message", function (msg, rinfo) {
	last = msg;
	console.log("server got: " + msg + " from " +
		rinfo.address + ":" + rinfo.port);
});

server.on("listening", function () {
	var address = server.address();
	console.log("server listening " +
	 	address.address + ":" + address.port);
});

server.bind(1337);



setInterval(function() {
	console.log(last);
}, 5000)