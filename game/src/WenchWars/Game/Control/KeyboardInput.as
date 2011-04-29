package WenchWars.Game.Control 
{
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.display.Sprite;
	
	import WenchWars.Game.Processor;
	import WenchWars.View;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class KeyboardInput
	{
		public static var _instance:KeyboardInput = null;
		protected var _registry:Object = new Object();
		
		public static function getInstance():KeyboardInput
		{
			if (KeyboardInput._instance === null)
			{
				KeyboardInput._instance = new KeyboardInput();
			}
			return KeyboardInput._instance;
		}
		
		public function KeyboardInput()
		{	
			View.getInstance().getStage().addEventListener(KeyboardEvent.KEY_DOWN, this._onKeyDown);
			View.getInstance().getStage().addEventListener(KeyboardEvent.KEY_UP, this._onKeyUp);
		}
		
		public function registerKey(keyCode:int, onKeyDown:Function, onKeyUp:Function = null, onKeyFrame:Function = null):void
		{
			var key:Key = new Key();
			key.setKeyDownFunction(onKeyDown);
			key.setKeyUpFunction(onKeyUp);
			key.setKeyFrameFunction(onKeyFrame);
			this._registry[keyCode] = key;
		}
		
		protected function _getKeyByKeyCode(keyCode:Number):Key
		{
			return this._registry[keyCode];
		}
		
		protected function _onKeyDown(e:KeyboardEvent):void
		{
			var key:Key = this._getKeyByKeyCode(e.keyCode);
			if (key != null && key.getActive() == false)
			{
				key.setActivityUpdateStatus(true);
				key.setActivityUpdateNeeded(true);
			}
		}
		
		protected function _onKeyUp(e:KeyboardEvent):void
		{
			var key:Key = this._getKeyByKeyCode(e.keyCode);
			if (key != null)
			{
				key.setActivityUpdateStatus(false);
				key.setActivityUpdateNeeded(true);
			}
		}
		
		public function update():void
		{
			var callback:Function = null;
			for each(var key:Key in this._registry)
			{
				if (key.getActivityUpdateNeeded())
				{
					if (key.getActivityUpdateStatus() == true)
					{
						callback = key.getKeyDownFunction();
						key.setActive(true);
					}
					else
					{
						callback = key.getKeyUpFunction();
						key.setActive(false);
					}
					key.setActivityUpdateNeeded(false);
				}
				
				if (callback != null)
				{
					callback();
				}
				else
				{
					if (key.getActive())
					{
						callback = key.getKeyFrameFunction();
						if (callback != null)
						{
							callback();
						}
					}
				}
				callback = null;
			}
		}
	}
}