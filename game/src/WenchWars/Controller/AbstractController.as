package WenchWars.Controller 
{
	import WenchWars.View;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class AbstractController
	{
		protected var _view:View;
		
		public function AbstractController()
		{
		}
		
		public function init():void
		{
			this._view = View.getInstance();
		}
				
		public function display():void
		{}
		
		public function destruct():void
		{}
	}

}