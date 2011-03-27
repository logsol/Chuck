package
{	
	import flash.display.Loader; 
	import flash.system.LoaderContext;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;	
	import WenchWars.Tool.EmbedHandler;
	import flash.external.ExternalInterface;
	import flash.events.Event;
	
	import flash.text.TextField;
    import flash.external.ExternalInterface;
	
	public class Test extends Sprite
	{	
		public function Test()
		{
			try
			{
				var chuck:MovieClip = EmbedHandler.load(EmbedHandler.CHUCK);
				//var chuck:MovieClip = EmbedHandler.load(5);
				chuck.head.x = 20;
				chuck.head.y = 100;
				addChild(chuck.head);
				
			}
			catch(e:Error)
			{
				if (ExternalInterface.available)
				{
					ExternalInterface.call("console.error", e.getStackTrace());					
				}
				else
				{
					throw e;
				}
			}
		}
	}
}
