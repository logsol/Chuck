package {
    public class JServ {
       
        public var _sVersion:String;

        public function JServ(){
            this._sVersion = "JServ 0.001a";
        }
        public function print(_sMsg:String):void {
            trace("\n" + this._sVersion + ": " + _sMsg);
        }
    }
}