﻿package
{	
	import flash.errors.*;
	import flash.events.*;
	import flash.net.Socket;
	
	import flash.system.Security;
	

	public class CustomSocket extends Socket {
	    private var response:String;

	    public function CustomSocket(host:String = null, port:uint = 0) {
	    	
	    	try {
	    		super(host, port);
			} catch(e:*) {
				Out.put("construct: " + e);
			}
	        
	        configureListeners();
	        
	        Out.put("");
	    }

	    private function configureListeners():void {
	        addEventListener(Event.CLOSE, closeHandler);
	        addEventListener(Event.CONNECT, connectHandler);
	        addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
	        addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
	        addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
	    }

	    private function writeln(str:String):void {
	        str += "\n";
	        try {
	            writeUTFBytes(str);
	        }
	        catch(e:IOError) {
	            Out.put(e);
	        }
	    }

	    private function sendRequest():void {
	        Out.put("send request");
	        response = "";
	        writeln("hi, im flash");
	        flush();
	    }

	    private function readResponse():void {
	        var str:String = readUTFBytes(bytesAvailable);
	        response += str;
	        Out.put(str);
	    }

	    private function closeHandler(event:Event):void {
	        Out.put("closeHandler: " + event);
	        Out.put(response.toString());
	    }

	    private function connectHandler(event:Event):void {
	        //Out.put("connectHandler: " + event);
	    	Out.put("connected");
	        sendRequest();
	    }

	    private function ioErrorHandler(event:IOErrorEvent):void {
	        Out.put("ioErrorHandler: " + event);
	    }

	    private function securityErrorHandler(event:SecurityErrorEvent):void {
	        Out.put("securityErrorHandler: " + event);
	    }

	    private function socketDataHandler(event:ProgressEvent):void {
	        //Out.put("socketDataHandler: " + event);
	        readResponse();
	    }
	}
}