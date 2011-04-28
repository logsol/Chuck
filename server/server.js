var net = require('net');
var clients = [];

function client(socket){
	this.socket = socket;
	this.name = null;
	this.isHost = false;

	this.talk = function(){
		console.log(this);
	}
}

function onClientConnect(socket) {
	socket.write("Welcome\r\n");

	var c = new client(socket);

	if(!clients.length) {
		c.isHost = true;
	}

	socket.write(c.isHost ? 'host' : 'client' + "\r\n");

	clients.push(c);

	//c.talk();
}

var server = net.createServer(function(socket){
	onClientConnect(socket);

	
});

server.listen(6937, "127.0.0.1");


// call: nc localhost 6937
