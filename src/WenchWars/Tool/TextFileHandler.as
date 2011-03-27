package WenchWars.Tool 
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class TextFileHandler
	{
		protected var callback:Function;
		
		public function load(source:String, callback:Function):void
		{
			this.callback = callback;
			
			var urlRequest:URLRequest = new URLRequest(source);
			var loader:URLLoader = new URLLoader();
			
			loader.load(urlRequest);
			
			loader.addEventListener(Event.COMPLETE, complete);			
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadError);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loadError);
		}
		
		protected function complete(event:Event):void
		{
			var loader:URLLoader = URLLoader(event.target);
			this.callback(loader.data);
		}
		
		protected function loadError(e:*):void
		{
			trace('LOADING ERROR; ' + e);
		}
	}

}