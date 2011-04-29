package WenchWars.Controller
{
	import flash.display.Sprite
	
	import WenchWars.Game.Processor;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class GameController extends AbstractController
	{	
		protected var processor:Processor;
		
		override public function display():void
		{
			this.processor = Processor.getInstance();
			this.processor.actuate();
		}
		
		override public function destruct():void
		{
			this.processor = null;
		}
		
	}
}