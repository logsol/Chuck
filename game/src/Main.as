package
{	
	import flash.display.Sprite;
	import flash.display.Stage;
	import WenchWars.Controller;
	import WenchWars.Config.Settings;
	import WenchWars.View;
	import flash.external.ExternalInterface;
	
	import WenchWars.Tool.Debug.Out;
	
	[SWF( frameRate="30", backgroundColor="0x222222", width="550", height="400" )]
	public class Main extends Sprite
	{	
		public function Main()
		{
			try
			{
				View.getInstance().init(stage);
				Controller.getInstance().select('start');
				
				//Out.put("The animation still has some bugs, \nbut we'll get there ;)");
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