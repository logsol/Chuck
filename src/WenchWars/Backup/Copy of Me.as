package WenchWars.Game 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Collision.Shapes.b2ShapeDef;
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2CircleShape;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import WenchWars.Game.Physic.Engine;
	import WenchWars.Config.Settings;
	import WenchWars.Game.Model.Repository;
	import WenchWars.Tool.EmbedHandler;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class Me
	{
		protected var _body:b2Body;
		protected var _standing:Boolean;
		protected var _mc:MovieClip;
		protected var _currentAnimationState:String;
		protected var _lookDirection:Number;

		public function Me():void
		{
			this.bear();
		}
		
		protected function bear():void
		{
			this._body = this._createBody();
			this._mc = EmbedHandler.load(EmbedHandler.CHUCK);
			Repository.getInstance().createModel(this._mc, this._body);
		}
		
		public function getBody():b2Body
		{
			return this._body;
		}
		
		public function setStanding(isStanding:Boolean):void
		{
			if (this._currentAnimationState == 'jump' && !this._standing && isStanding)
			{
				this._animate('stand');
			}
			this._standing = isStanding;
		}
		
		public function isStanding():Boolean
		{
			return this._standing;
		}
			
		public function move(direction:int):void
		{
			this._body.WakeUp();
			var vector:b2Vec2 = new b2Vec2(Settings.WALK_SPEED * direction, this._body.GetLinearVelocity().y);
			this._body.SetLinearVelocity(vector);
			
			if (this._standing && this._currentAnimationState != 'jump')
			{
				this._animate('walk', direction);
			}
		}
		
		public function stop():void
		{
			if (this._currentAnimationState == 'walk')
			{
				this._animate('stand');
			}
			if (this._standing)
			{
				this._animate('stand');
			}
		}
		
		public function preJump():void
		{
			if (this._standing)
			{
				this._animate('prejump');
			}
		}
		
		public function jump():void
		{
			if (this.isStanding() && this._body.GetLinearVelocity().y >= -3)
			{
				this._body.WakeUp();
				var vector:b2Vec2 = new b2Vec2(0, -Settings.JUMP_SPEED);
				this._body.ApplyImpulse(vector, this._body.GetPosition());
				this._animate('jump');
			}
		}
		
		public function duck():void
		{
			if (this._standing)
			{
				this._animate('duck');
			}
		}
		
		public function standUp():void
		{
			if (this._standing)
			{
				this._animate('standup');
			}
		}
		
		protected function _animate(type:String, moveDirection:Number = 0):void
		{
			if (type == this._currentAnimationState)
			{
				return;
			}
			
			switch(type)
			{
				case 'walk':
					if (moveDirection == 1 && this._lookDirection == 1 || moveDirection == -1 && this._lookDirection == -1)
					{
						this._mc.gotoAndPlay('walk');
					} else 	{
						this._mc.gotoAndPlay('walkback');
					}
				  break;
				  
				default:
					this._mc.gotoAndPlay(type);
				  break;
			}
			this._currentAnimationState = type;
		}
		
		public function look(x:Number, y:Number):void
		{
			var degree:Number = Math.atan2(Settings.STAGE_WIDTH / 2 - x, Settings.STAGE_HEIGHT / 2 - 33 - y)/(Math.PI/180);
			
			if (x < Settings.STAGE_WIDTH / 2)
			{
				this._mc.scaleX = -1;
				this._lookDirection = -1;
				
				degree = (-45 + degree / 2);
				this._mc.head.rotation = degree; // -90 - 90
				
			} 
			else if (x >= Settings.STAGE_WIDTH / 2)
			{
				this._mc.scaleX = 1;
				this._lookDirection = 1;
				
				degree = (45 + -degree / 2) - 90;
				this._mc.head.rotation = degree; // 90 - 270
			}
		}
		
		public function update():void
		{		
			this._mc.head.y = this._mc.head_posmask.y;
			
			if (this._currentAnimationState != 'duck'
					&& this._body.IsSleeping() 
				|| this._body.GetLinearVelocity().x == 0 
					&& this._body.GetLinearVelocity().y == 0 
					&& this._currentAnimationState != 'duck')
			{
				//this._animate('stand');
			}
		}
		
		protected function _createBody():b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.x = 220 / Settings.RATIO;
			bodyDef.position.y = 0 / Settings.RATIO;
			bodyDef.fixedRotation = true;
			bodyDef.linearDamping = 1;
			
			var headShapeDef:b2CircleDef = new b2CircleDef();
			headShapeDef.radius = 5 / Settings.RATIO;
			headShapeDef.density = Settings.ME_DENSITY;
			headShapeDef.friction = 0;
			headShapeDef.restitution = Settings.ME_RESTITUTION;
			headShapeDef.localPosition.Set(-1 / Settings.RATIO, -37 / Settings.RATIO);
			headShapeDef.userData = 'myHead';
			
			// Circle
			//var bodyShapeDef:b2PolygonDef = new b2PolygonDef();
			//bodyShapeDef.vertexCount = 4;
			//bodyShapeDef.vertices[0].Set(-9   / Settings.RATIO,  -12 / Settings.RATIO);
			//bodyShapeDef.vertices[1].Set( 9   / Settings.RATIO,  -12 / Settings.RATIO);
			//bodyShapeDef.vertices[2].Set( 7   / Settings.RATIO,    6 / Settings.RATIO);
			//bodyShapeDef.vertices[3].Set(-7   / Settings.RATIO,    6 / Settings.RATIO);
			
			//bodyShapeDef.density = Settings.ME_DENSITY;
			//bodyShapeDef.friction = Settings.ME_FRICTION;
			//bodyShapeDef.restitution = Settings.ME_RESTITUTION;
			//bodyShapeDef.userData = 'myBody';
			
			// Box
			var bodyShapeDef:b2PolygonDef = new b2PolygonDef();
			bodyShapeDef.SetAsOrientedBox(5 / Settings.RATIO, 16 / Settings.RATIO, new b2Vec2(-1 / Settings.RATIO, -21 / Settings.RATIO));
			bodyShapeDef.friction = 0;
			bodyShapeDef.density = Settings.ME_DENSITY;
			bodyShapeDef.restitution = Settings.ME_RESTITUTION;
			bodyShapeDef.userData = 'myBody';
			
			var legsShapeDef:b2CircleDef = new b2CircleDef();
			legsShapeDef.radius = 5 / Settings.RATIO;
			legsShapeDef.density = Settings.ME_DENSITY;
			legsShapeDef.friction = Settings.ME_FRICTION;
			legsShapeDef.restitution = Settings.ME_RESTITUTION;
			legsShapeDef.localPosition.Set(-1 / Settings.RATIO, -5 / Settings.RATIO);
			legsShapeDef.userData = 'myLegs';
			
			var feetShapeDef:b2CircleDef = new b2CircleDef();
			feetShapeDef.radius = 4 / Settings.RATIO;
			feetShapeDef.density = Settings.ME_DENSITY;
			feetShapeDef.friction = Settings.ME_FRICTION;
			feetShapeDef.restitution = Settings.ME_RESTITUTION;
			feetShapeDef.localPosition.Set(-1 / Settings.RATIO, 0 / Settings.RATIO);
			feetShapeDef.isSensor = true;
			feetShapeDef.userData = 'myFeet';
			
			var body:b2Body = Processor.getInstance().getEngine().createBody(bodyDef);
			body.CreateShape(headShapeDef);
			body.CreateShape(bodyShapeDef);
			body.CreateShape(legsShapeDef);
			body.CreateShape(feetShapeDef);
			body.SetMassFromShapes();
			
			return body;
		}
	}
}