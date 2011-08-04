package WenchWars.Game.Model
{
	import flash.display.DisplayObject;
	
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Common.b2Settings;
	
	import WenchWars.Config.Settings;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class Model
	{
		protected var _graphic:DisplayObject;
		protected var _body:b2Body;
		
		public function Model(g:DisplayObject, b:b2Body):void 
		{
			this._graphic = g;
			this._body = b;
		}
		
		public function update():void
		{
			var bodyPosition:b2Vec2 = this._body.GetPosition();	
			
			this._graphic.rotation = this._body.GetAngle() * 360 / Math.PI / 2;
			this._graphic.x = bodyPosition.x * Settings.RATIO;
			this._graphic.y = bodyPosition.y * Settings.RATIO;
			
		}
	}
}