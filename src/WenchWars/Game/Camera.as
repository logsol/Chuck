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
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class Camera
	{
		protected var stage:Stage;
		protected var gameSprite:Sprite;
		public var mouseX:Number = 0;
		public var mouseY:Number = 0;
		protected var shouldX:Number = 0;
		protected var shouldY:Number = 0;
		
		protected static var instance:Camera = null;
		
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
			var me:Me = Processor.getInstance().getMe();
			var sprite:Sprite = View.getInstance().getSprite();
			
			sprite.x = me.getBody().GetPosition().x * Settings.RATIO * -1 + Settings.STAGE_WIDTH  / 2 - ((this.mouseX - Settings.STAGE_WIDTH  / 2) / 2);
			sprite.y = me.getBody().GetPosition().y * Settings.RATIO * -1 + Settings.STAGE_HEIGHT / 2 - ((this.mouseY - Settings.STAGE_HEIGHT / 2) / 2);
		}
		
		public function mouseMove(e:MouseEvent):void
		{
			this.mouseX = e.stageX;
			this.mouseY = e.stageY;
			
			Processor.getInstance().getMe().look(e.stageX, e.stageY);
		}
	}
}