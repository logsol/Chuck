package WenchWars.Game.Control 
{
	import WenchWars.Game.Control.KeyboardInput;
	import WenchWars.Game.Me;
	import WenchWars.Game.Processor;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class InputControlUnit
	{
		protected var _ki:KeyboardInput;
		protected var _me:Me;
		protected var _moving:Boolean = false;
		
		public function InputControlUnit():void 
		{
			this._me = Processor.getInstance().getMe();
			this._ki = new KeyboardInput(this);
		}
		
		public function move(direction:int):void
		{
			this._me.move(direction);
			this._moving = true;
		}
		
		public function stop():void
		{
			if (this._moving)
			{
				this._me.stop();
				this._moving = false;
			}
		}
		
		public function preJump():void
		{
			this._me.preJump();
		}
		
		public function jump():void
		{
			this._me.jump();
		}
		
		public function duck():void
		{
			this._me.duck();
		}
		
		public function standUp():void
		{
			this._me.standUp();
		}
	}

}