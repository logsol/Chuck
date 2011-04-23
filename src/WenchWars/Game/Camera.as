package WenchWars.Game 
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Sprite;

	import Box2D.Common.Math.b2Vec2;
	
	import WenchWars.View;
	import WenchWars.Config.Settings;
	import WenchWars.Controller;
	import WenchWars.Game.Player;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class Camera
	{
		protected static var instance:Camera = null;

		protected var _player:Player;
		public var mouseX:Number = 0;
		public var mouseY:Number = 0;
		
		
		public static function getInstance():Camera
		{
			if (Camera.instance === null)
			{
				Camera.instance = new Camera();
			}
			return Camera.instance;
		}
		
		public function Camera()
		{
			this.init();
		}
		
		public function init():void 
		{
			View.getInstance().getStage().addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		}
		
		public function update():void
		{
			var sprite:Sprite = View.getInstance().getSprite();
			
			if(this._player)
			{
				sprite.x = this._player.getBody().GetPosition().x * Settings.RATIO * -1 + Settings.STAGE_WIDTH  / 2 - ((this.mouseX - Settings.STAGE_WIDTH  / 2) / 2);
				sprite.y = this._player.getBody().GetPosition().y * Settings.RATIO * -1 + Settings.STAGE_HEIGHT / 2 - ((this.mouseY - Settings.STAGE_HEIGHT / 2) / 2);
			}
		}
		
		public function mouseMove(e:MouseEvent):void
		{
			this.mouseX = e.stageX;
			this.mouseY = e.stageY;
			
			if(this._player) this._player.look(e.stageX, e.stageY);
		}
		
		public function follow(player:Player):void
		{
			this._player = player;
		}
	}
}