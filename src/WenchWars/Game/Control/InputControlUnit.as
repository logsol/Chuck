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
		public static var _instance:InputControlUnit = null;
		protected var _ki:KeyboardInput;
		protected var _me:Me;
		protected var _shift:Boolean = false;

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
			
			this._ki.registerKey(65, this.moveLeft, this.stop, this.moveLeft);
			this._ki.registerKey(68, this.moveRight, this.stop, this.moveRight);
			this._ki.registerKey(87, this.preJump, this.jump, this.preJump);
			this._ki.registerKey(83, this.duck, this.standUp, this.duck);
			this._ki.registerKey(83, this.activateShift, this.activateShift, this.deactivateShift);
			
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