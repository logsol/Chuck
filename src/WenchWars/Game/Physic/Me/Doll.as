package WenchWars.Game.Physic.Me
{
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Collision.Shapes.b2ShapeDef;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2Shape;
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
		protected var _legs:b2Shape;
		protected var _contactPoint:b2ContactPoint;
		
		public function Doll() 
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.x = 220 / Settings.RATIO;
			bodyDef.position.y = 0 / Settings.RATIO;
			bodyDef.fixedRotation = true;
			bodyDef.linearDamping = Settings.ME_LINEAR_DAMPING;
			
			var headShapeDef:b2CircleDef = new b2CircleDef();
			headShapeDef.radius = 5 / Settings.RATIO;
			headShapeDef.density = Settings.ME_DENSITY;
			headShapeDef.friction = 0;
			headShapeDef.restitution = Settings.ME_RESTITUTION;
			headShapeDef.localPosition.Set(0 / Settings.RATIO, -37 / Settings.RATIO);
			headShapeDef.userData = 'myHead';
			
			var bodyShapeDef:b2PolygonDef = new b2PolygonDef();
			bodyShapeDef.SetAsOrientedBox(5 / Settings.RATIO, 16 / Settings.RATIO, new b2Vec2(0 / Settings.RATIO, -21 / Settings.RATIO));
			bodyShapeDef.friction = 0;
			bodyShapeDef.density = Settings.ME_DENSITY;
			bodyShapeDef.restitution = Settings.ME_RESTITUTION;
			bodyShapeDef.userData = 'myBody';
			
			var legsShapeDef:b2CircleDef = new b2CircleDef();
			legsShapeDef.radius = 5 / Settings.RATIO;
			legsShapeDef.density = Settings.ME_DENSITY;
			legsShapeDef.friction = Settings.ME_FRICTION;
			legsShapeDef.restitution = Settings.ME_RESTITUTION;
			legsShapeDef.localPosition.Set(0 / Settings.RATIO, -5 / Settings.RATIO);
			legsShapeDef.userData = 'myLegs';
			
			var feetShapeDef:b2CircleDef = new b2CircleDef();
			feetShapeDef.radius = 4 / Settings.RATIO;
			feetShapeDef.density = 0;
			feetShapeDef.friction = 0;
			feetShapeDef.restitution = 0;
			feetShapeDef.localPosition.Set(0 / Settings.RATIO, 0 / Settings.RATIO);
			feetShapeDef.isSensor = true;
			feetShapeDef.userData = 'myFeet';
			
			this._body = Processor.getInstance().getEngine().createBody(bodyDef);
			this._body.CreateShape(headShapeDef);
			this._body.CreateShape(bodyShapeDef);
			this._legs = this._body.CreateShape(legsShapeDef);
			this._body.CreateShape(feetShapeDef);
			this._body.SetMassFromShapes();
		}
		
		public function getBody():b2Body
		{
			return this._body;
		}
		
		protected function _setFriction(friction:Number = -1):void
		{
			if (this._legs.GetFriction() != friction)
			{
				this._legs.m_friction = friction;
			}
		}
		
		public function move(direction:int, speed:Number):void
		{
			this._setFriction(Settings.ME_MOTION_FRICTION);
			this._body.WakeUp();
			var vector:b2Vec2 = new b2Vec2(speed * direction, this._body.GetLinearVelocity().y);
			this._body.SetLinearVelocity(vector);
		}
		
		public function stop():void
		{
			this._setFriction(Settings.ME_FRICTION);
		}
		
		public function jump():void
		{
			this._body.WakeUp();
			
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