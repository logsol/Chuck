/**
* @mxmlc -default-size 800 600 -incremental=true -default-background-color=0x000000
*/
package
{	
	import flash.display.Sprite;
	import flash.display.Stage;
	import WenchWars.Controller;
	import WenchWars.Config.Settings;
	import WenchWars.View;
	
	[SWF( frameRate="30", backgroundColor="0x222222", width="550", height="400" )]
	public class Main extends Sprite
	{	
		public function Main()
		{
			View.getInstance().init(stage);
			
			Controller.getInstance().select('start');
		}	
	}
	
	

}