var net = require('net');
var clients = [];

function client(socket){
	this.socket = socket;
	this.name = null;

	this.talk = function(){
		console.log("hi, im a client, my name is " + this.name);
	}
}

function onClientConnect(socket) {
	socket.write("Welcome\r\n");

	var c = new client(socket);
	c.name = "peter";
	clients.push(c);

	clients[0].talk();
}

var server = net.createServer(function(socket){
	onClientConnect(socket);
});

server.listen(6937, "127.0.0.1");



// call: nc localhost 6937
