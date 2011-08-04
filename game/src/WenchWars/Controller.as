package WenchWars 
{
	import WenchWars.Controller.*;
	import WenchWars.View;
	
	public class Controller
	{
		protected static var _instance:Controller = null;
		protected var _currentController:AbstractController = null;
		
		public static function getInstance():Controller
		{
			if (Controller._instance === null)
			{
				Controller._instance = new Controller();
			}
			return Controller._instance;
		}
				
		public function select(controller:String):void
		{
			this.deselect();
			
			switch(controller)
			{
				case 'start':
					this._currentController = new StartController();
				  break;
				  
				case 'game':
					this._currentController = new GameController();
				  break;
			}
			
			this._currentController.init();
			this._currentController.display();
		}
		
		public function deselect():void
		{	
			View.getInstance().refreshSprite();
			
			if (this._currentController !== null)
			{
				this._currentController.destruct();
				this._currentController = null;
			}
		}
		
		public function getCurrentController():*
		{
			return this._currentController;
		}
	}
}