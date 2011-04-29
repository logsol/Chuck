package WenchWars.Game 
{
	import flash.display.Sprite;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.utils.*;
	
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	
	import WenchWars.View;
	import WenchWars.Config.Settings;
	import WenchWars.Tool.DisplayFileHandler;
	import WenchWars.Game.Camera;
	import WenchWars.Game.Loader.Items;
	import WenchWars.Game.Loader.Level;
	import WenchWars.Game.Model.Repository
	import WenchWars.Game.Control.InputControlUnit;
	import WenchWars.Game.Control.KeyboardInput;
	import WenchWars.Game.Collision.CollisionDetector;
	import WenchWars.Game.Physic.Engine;
	import WenchWars.Tool.Debug.*;
	
	import WenchWars.Tool.Debug.Arrow;
	
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class Processor
	{
		protected static var _instance:Processor = null;
		public static var count:int = 0;
		protected var _me:Player;
		protected var _engine:Engine;
		protected var _camera:Camera;
		protected var _repository:Repository;
		protected var _inputControlUnit:InputControlUnit;
		protected var _keyboardInput:KeyboardInput;
		
		public static function getInstance():Processor
		{
			if (Processor._instance === null)
			{
				Processor._instance = new Processor();
			}
			return Processor._instance;
		}
		
		public function actuate():void
		{
			this._engine     = new Engine();
			this._me         = new Player();
			var player2:Player = new Player();
			
			this._camera     = Camera.getInstance()
			this._repository = Repository.getInstance();
			
			this._engine.setCollisionDetector();
			
			this._inputControlUnit = InputControlUnit.getInstance();
			this._keyboardInput    = KeyboardInput.getInstance();
			
			new Level();
			new Items();
			
			Out.put("Players spawn after 3 seconds.");
			Out.put("Notice, that Player2 seems to be afk xD");
			
			setTimeout(this.spawnPlayers, 3000, this._me, player2);
			
			View.getInstance().getSprite().addEventListener(Event.ENTER_FRAME, this._update)
		}
		
		private function spawnPlayers(p1:Player, p2:Player):void
		{
			p1.spawn(50, 250);
			p2.spawn(580, 10);
			
			this._camera.follow(p1);
		}
		
		public function getMe():Player
		{
			return this._me;
		}
		
		public function getEngine():Engine
		{
			return this._engine;
		}
			
		public function _update(e:Event):void
		{
			Processor.count++;
			// Order is important
			this._engine.update();
			this._repository.update();
			this._keyboardInput.update();
			this._me.update();
			this._camera.update();
		}
	}
}