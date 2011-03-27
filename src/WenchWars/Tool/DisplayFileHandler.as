package WenchWars.Tool 
{
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.*;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class DisplayFileHandler
	{
		protected var callback:Function;
		protected var loader:Loader;
		
		public function load(source:String, callback:Function):void
		{
			this.callback = callback;
			var urlRequest:URLRequest = new URLRequest(source);
			this.loader = new Loader();
			
			this.loader.load(urlRequest);
			
			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);			
			this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadError);
			this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
		}
		
		protected function complete(event:Event):void
		{
			this.callback(this.loader);
		}
		
		protected function loadError(e:*):void
		{
			trace('LOADING ERROR; ' + e);
		}
	}

}