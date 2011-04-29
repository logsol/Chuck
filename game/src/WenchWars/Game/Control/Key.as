package WenchWars.Game.Control 
{
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class Key
	{
		protected var _active:Boolean = false;
		protected var _activityUpdateStatus:Boolean = false;
		protected var _activityUpdateNeeded:Boolean = false;
		protected var _keyDown:Function = null;
		protected var _keyUp:Function = null;
		protected var _keyFrame:Function = null;
		
		public function Key() 
		{
		}
				
		public function setActivityUpdateStatus(active:Boolean):void
		{
			this._activityUpdateStatus = active;
		}
		
		public function getActivityUpdateStatus():Boolean
		{
			return this._activityUpdateStatus;
		}
				
		public function setActivityUpdateNeeded(need:Boolean):void
		{
			this._activityUpdateNeeded = need;
		}
		
		public function getActivityUpdateNeeded():Boolean
		{
			return this._activityUpdateNeeded;
		}
		
		public function setActive(active:Boolean):void
		{
			this._active = active;
		}
		
		public function getActive():Boolean
		{
			return this._active;
		}
		
		public function setKeyDownFunction(f:Function):void
		{
			this._keyDown = f;
		}
		
		public function getKeyDownFunction():Function
		{
			return this._keyDown;
		}
		
		public function setKeyUpFunction(f:Function):void
		{
			this._keyUp = f;
		}
		
		public function getKeyUpFunction():Function
		{
			return this._keyUp;
		}
		
		public function setKeyFrameFunction(f:Function):void
		{
			this._keyFrame = f;
		}
		
		public function getKeyFrameFunction():Function
		{
			return this._keyFrame;
		}
	}
}