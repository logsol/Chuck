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
		public static const KEY_LEFT : int = 65;
		public static const KEY_RIGHT : int = 68;
		public static const KEY_UP : int = 87;
		public static const KEY_DOWN : int = 83;
		
		public static var _instance:InputControlUnit = null;
		protected var _ki:KeyboardInput;
		protected var _me:Me;
		protected var _shift:Boolean = false;
		protected var _isJumping:Boolean = false;

		public static function getInstance():InputControlUnit
		{
			if (InputControlUnit._instance === null)
			{
				InputControlUnit._instance = new InputControlUnit();
			}
			return InputControlUnit._instance;
		}
		
		public function InputControlUnit():void 
		{
			this._me = Processor.getInstance().getMe();
			this._ki = KeyboardInput.getInstance();
			
			this._ki.registerKey(KEY_LEFT, this.moveLeft, this.stop, this.moveLeft);
			this._ki.registerKey(KEY_RIGHT, this.moveRight, this.stop, this.moveRight);
			this._ki.registerKey(KEY_UP, this.jump, this.jumped, this.jumping);
			this._ki.registerKey(KEY_DOWN, this.duck, this.standUp, this.duck);
			this._ki.registerKey(KEY_DOWN, this.activateShift, this.activateShift, this.deactivateShift);
			
			this._ki.registerKey(37, this.wasd);
			this._ki.registerKey(38, this.wasd);
			this._ki.registerKey(39, this.wasd);
			this._ki.registerKey(40, this.wasd);
		}
		
		public function wasd():void
		{
			trace('wasd benutzen alter...');
		}
		
		public function moveLeft():void
		{
			this._me.move(-1);
		}
		
		public function moveRight():void
		{
			this._me.move(1);
		}
		
		public function stop():void
		{
			this._me.stop();
		}
		
		public function preJump():void
		{
			this._me.preJump();
		}
		
		public function jump():void
		{
			this._isJumping = true;
			this._me.jump();
		}
		
		public function jumped():void
		{
			this._isJumping = false;
		}
		
		public function jumping():void
		{
			if (this._isJumping)
			{
				this._me.jumping();			
			}
		}
		
		public function duck():void
		{
			this._me.duck();
		}
		
		public function standUp():void
		{
			this._me.standUp();
		}
		
		public function activateShift():void
		{
			this._shift = true;
		}
		
		public function deactivateShift():void
		{
			this._shift = false;
		}
	}
}