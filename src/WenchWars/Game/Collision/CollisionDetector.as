package WenchWars.Game.Collision 
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Collision.Shapes.b2ShapeDef;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.Contacts.b2ContactResult;
	
	import WenchWars.Game.Me;
	import WenchWars.Game.Processor;
	import WenchWars.Config.Settings;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class CollisionDetector extends b2ContactListener
	{
		protected var _me:Me;
		
		public function CollisionDetector():void
		{
			this._me = Processor.getInstance().getMe();
		}
		
		public override function Add(point:b2ContactPoint) : void
		{
			this.handleStand(point, true);
		}
	 
		public override function Persist(point:b2ContactPoint) : void
		{
			this.handleStand(point, true);
		}
	 
		public override function Remove(point:b2ContactPoint) : void
		{}
	 
		public override function Result(point:b2ContactResult) : void
		{}
		
		protected function handleStand(point:b2ContactPoint, isStanding:Boolean):void
		{
			if (point.shape1.GetUserData() == 'myFeet' || point.shape2.GetUserData() == 'myFeet') 
			{
				this._me.setStanding(isStanding);
			}
		}
	}
}