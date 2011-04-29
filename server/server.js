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
    socket.on("data", function(data) {
        var type = parseInt(data.toString("utf8", 0, 1));
        var message = "";
        if(data.length > 1) {
            message = data.toString("utf8", 1);
        }

        switch (type) {
        case 0: // echo
            socket.write(message);
            break;
        case 1: // my id
            socket.write(self.id + "\n");
            break;
        case 2: // set my name
            self.name = message.trim();
            socket.write(self.name + "\n");
            break;
        case 3: // am I host?
            socket.write(self.is_host + "\n");
            break;
        case 4: // send to client id
            break;
        case 5: // send to all
            break;
        case 6: // send to array
            break;
        }
    });
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


// call: nc localhost 6937

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
