var net = require('net');
var clients = [];
var new_client_id = 0;
var host = null;

function Client(socket, id){
	this.socket = socket;
	this.name = null;
	this.is_host = (id == 0);
	this.id = id;
	this.socket.write("Welcome " + (this.is_host ? 'host' : 'client') + "\n");

	var self = this;

	this.socket.on("data", function(data) {
		var type = parseInt(data.toString('utf8', 0, 1));
		var message = (data.length > 1) ? data.toString('utf8', 1).trim() : '';

		switch (type) {
			case 0: // echo
				socket.write(message);
				break;
			case 1: // my id
				socket.write(self.id + "\n");
				break;
			case 2: // set my name
				self.name = message;
				socket.write(self.name + "\n");
				break;
			case 3: // am I host?
				socket.write(self.is_host + "\n");
				break;
			case 4: // send to host
				//getClientById(1).send(message);
				host.send(message);
				break;
			case 5: // send to all
				sendToAll(message);
				break;
			case 6: // send to client
				break;
			case 7: // send to group
				break;
		}
	});

	this.socket.on("end", function(){
		clients.splice(clients.indexOf(self), 1);
		if(self === host)
		{
			for(var x in clients){
				clients[x].socket.end('host has left, sorry, goodbye' + "\n");
				clients[x] = null;
			}
			clients = [];
			host = null;
			new_client_id = 0;
		} 
		else {
			sendToAll('client ' + self.id + ' has left.' + "\n");
		}
		self = null;
	});

	this.send = function(message){
		this.socket.write(message + "\n");
	}
}

function sendToAll(message){
	for(var x in clients)
	{
		clients[x].send(message);
	}
}

function getClientById(id){
	for(var x in clients)
	{
		if(clients[x].id == id){
			return clients[x];
		}
	}
}

var server = net.createServer(function(socket) {
    socket.on('connect', function() {
        var c = new Client(socket, new_client_id++);
    	clients.push(c);
    	if (new_client_id == 1) {
    	    host = c;
    	}
    });
});

server.listen(6937, "127.0.0.1");



// helper
String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
}
String.prototype.ltrim = function() {
	return this.replace(/^\s+/,"");
}
String.prototype.rtrim = function() {
	return this.replace(/\s+$/,"");
}

// call: nc localhost 6937
