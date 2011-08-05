package {
	import avmplus.Socket;
	
    public class JServ {
       
        public var _sVersion:String;

        public function JServ(){
            this._sVersion = "JServ 0.001a";
        }
        public function JPrint(_sMsg:String):void {
            trace("\n" + this._sVersion + ": " + _sMsg + "\n" + Socket.localAddresses.join( "\n" ));
        }
    }
}