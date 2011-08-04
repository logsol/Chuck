package WenchWars.Game.Collision 
{
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Collision.b2Manifold;
	
	import WenchWars.Game.Player;
	import WenchWars.Game.Processor;
	import WenchWars.Config.Settings;
	import WenchWars.Tool.Debug.*;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class CollisionDetector extends b2ContactListener
	{
		protected var _me:Player;
		
		public function CollisionDetector():void
		{
			this._me = Processor.getInstance().getMe();
		}
		
		public override function BeginContact(point:b2Contact) : void
		{
			this.handleStand(point, true);
		}
		
		public override function PostSolve(point:b2Contact, impulse:b2ContactImpulse) : void
		{
			this.handleStand(point, true);
		}
		
		public override function EndContact(point:b2Contact):void
		{
			this.handleStand(point, false);
		}
		
		/*
		public override function PreSolve(point:b2Contact, oldManifold:b2Manifold):void
		{}
	 	*/

		protected function handleStand(point:b2Contact, isColliding:Boolean):void
		{
			if (point.GetFixtureA().GetUserData() == 'myFeet' || point.GetFixtureB().GetUserData() == 'myFeet') 
			{
				this._me.onFootSensorDetection(isColliding);
			}
		}
	}
}