package WenchWars.Game.Physic.Player
{
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;

	import flash.display.Shape;
	
	import WenchWars.Config.Settings;
	import WenchWars.Game.Processor;
	import WenchWars.Tool.Debug.*;
	
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class Doll
	{
		protected var _body:b2Body;
		protected var _legs:b2Fixture;
		protected var _contactPoint:b2ContactPoint;
		
		public function Doll() 
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.x = 220 / Settings.RATIO;
			bodyDef.position.y = 0 / Settings.RATIO;
			bodyDef.fixedRotation = true;
			bodyDef.linearDamping = Settings.PLAYER_LINEAR_DAMPING;
			bodyDef.type = b2Body.b2_dynamicBody;
			
			this._body = Processor.getInstance().getEngine().createBody(bodyDef);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.density = Settings.PLAYER_DENSITY;
			fixtureDef.friction = 0;
			fixtureDef.restitution = Settings.PLAYER_RESTITUTION;
			
			
			var headShape:b2CircleShape = new b2CircleShape();
			headShape.SetRadius(5 / Settings.RATIO);
			headShape.SetLocalPosition(new b2Vec2(0 / Settings.RATIO, -37 / Settings.RATIO));
			fixtureDef.shape = headShape;
			fixtureDef.isSensor = false;
			fixtureDef.userData = 'myHead';
			this._body.CreateFixture(fixtureDef);
			
			var bodyShape:b2PolygonShape = new b2PolygonShape();
			bodyShape.SetAsOrientedBox(5 / Settings.RATIO, 16 / Settings.RATIO, new b2Vec2(0 / Settings.RATIO, -21 / Settings.RATIO));
			fixtureDef.shape = bodyShape;
			fixtureDef.isSensor = false;
			fixtureDef.userData = 'myBody';
			this._body.CreateFixture(fixtureDef);
			
			var legsShape:b2CircleShape = new b2CircleShape();
			legsShape.SetRadius(5 / Settings.RATIO);
			legsShape.SetLocalPosition(new b2Vec2(0 / Settings.RATIO, -5 / Settings.RATIO));
			fixtureDef.shape = legsShape;
			fixtureDef.friction = Settings.PLAYER_FRICTION;
			fixtureDef.isSensor = false;
			fixtureDef.userData = 'myLegs';
			this._legs = this._body.CreateFixture(fixtureDef);
		
			var feetShape:b2CircleShape = new b2CircleShape();
			feetShape.SetRadius(4 / Settings.RATIO);
			feetShape.SetLocalPosition(new b2Vec2(0 / Settings.RATIO, 0 / Settings.RATIO));
			fixtureDef.shape = feetShape;
			fixtureDef.isSensor = true;
			fixtureDef.userData = 'myFeet';
			this._body.CreateFixture(fixtureDef);

			this._body.SetActive(false);
		}
		
		public function spawn(x:int, y:int):void
		{
			this._body.SetPosition(new b2Vec2(x / Settings.RATIO, y / Settings.RATIO));
			this._body.SetActive(true);
		}
		
		public function getBody():b2Body
		{
			return this._body;
		}
		
		protected function _setFriction(friction:Number = -1):void
		{
			if (this._legs.GetFriction() != friction)
			{
				this._legs.SetFriction(friction);
			}
		}
		
		public function move(direction:int, speed:Number):void
		{
			this._setFriction(Settings.PLAYER_MOTION_FRICTION);
			this._body.SetAwake(true);
			var vector:b2Vec2 = new b2Vec2(speed * direction, this._body.GetLinearVelocity().y);
			this._body.SetLinearVelocity(vector);
		}
		
		public function stop():void
		{
			this._setFriction(Settings.PLAYER_FRICTION);
		}
		
		public function jump():void
		{
			this._body.SetAwake(true);
			
			var vector:b2Vec2 = new b2Vec2(0, -Settings.JUMP_SPEED);
			this._body.ApplyImpulse(vector, this._body.GetPosition());
			
			// maybe change to a constant force instead of applying of force?
			// to prevent higher jumping running uphill, etc.
		}
		
		public function jumping():void
		{
			var vector:b2Vec2 = new b2Vec2(0, -0.1);
			this._body.ApplyImpulse(vector, this._body.GetPosition());
		}
	}

}