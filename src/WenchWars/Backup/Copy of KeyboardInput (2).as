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
		protected var _registry:Object = new Object();
		
		public function KeyboardInput():void 
		{	
			View.getInstance().getStage().addEventListener(KeyboardEvent.KEY_DOWN, this._onKeyDown);
			View.getInstance().getStage().addEventListener(KeyboardEvent.KEY_UP, this._onKeyUp);
			View.getInstance().getStage().addEventListener(Event.ENTER_FRAME, this._run);
		}
		
		public function registerKey(keyCode:Number, onKeyDown:Function, onKeyUp:Function = null, onKeyFrame:Function = null):void
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
				key.setActive(true);
				var callBack:Function = key.getKeyDownFunction();
				if (callBack != null)
				{
					callBack();
				}
			}
		}
		
		protected function _onKeyUp(e:KeyboardEvent):void
		{
			var key:Key = this._getKeyByKeyCode(e.keyCode);
			if (key != null)
			{
				key.setActive(false);
				var callBack:Function = key.getKeyUpFunction();
				if (callBack != null) 
				{
					callBack();
				}
			}
		}
		
		protected function _run(e:Event):void
		{
			var callBack:Function;
			for each(var key:Key in this._registry)
			{
				if (key.getActive())
				{
					callBack = key.getKeyFrameFunction();
					if (callBack != null)
					{
						callBack();
					}
				}
			}
		}
	}
}