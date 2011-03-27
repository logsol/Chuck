package WenchWars.Game.Physic 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import flash.display.Sprite;
	
	import Box2D.Dynamics.b2World;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2DebugDraw;
	
	import WenchWars.View;
	import WenchWars.Config.Settings;
	import WenchWars.Game.Processor;
	import WenchWars.Game.Collision.CollisionDetector;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class Engine
	{
		protected var _world:b2World;
		
		public function Engine():void
		{
			this._world = this._initBox2d();
			this._setupDebugDraw();
		}
		
		protected function _initBox2d():b2World
		{
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(-Settings.BOX2D_WORLD_AABB_SIZE / 2 / Settings.RATIO, -Settings.BOX2D_WORLD_AABB_SIZE / 2 / Settings.RATIO);
			worldAABB.upperBound.Set( Settings.BOX2D_WORLD_AABB_SIZE / 2 / Settings.RATIO,  Settings.BOX2D_WORLD_AABB_SIZE / 2 / Settings.RATIO);
			
			return new b2World(worldAABB, new b2Vec2(0, Settings.BOX2D_GRAVITY), Settings.BOX2D_ALLOW_SLEEP);
		}
		
		public function getWorld():b2World
		{
			return this._world;
		}
		
		public function setCollisionDetector():void
		{
			var cd:CollisionDetector = new CollisionDetector();
			this._world.SetContactListener(cd);
		}
		
		public function _setupDebugDraw():void
		{
			var debugSprite:Sprite = new Sprite();
			View.getInstance().add(debugSprite);
			
			// set debug draw
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			
			dbgDraw.m_sprite = debugSprite;
			dbgDraw.m_drawScale = Settings.RATIO;
			dbgDraw.m_fillAlpha = 0.1;
			dbgDraw.m_lineThickness = 0;
			
			dbgDraw.m_drawFlags = null
				| b2DebugDraw.e_shapeBit 
				//| b2DebugDraw.e_jointBit 
				//| b2DebugDraw.e_coreShapeBit
				//| b2DebugDraw.e_aabbBit
				//| b2DebugDraw.e_centerOfMassBit
				//| b2DebugDraw.e_obbBit
				//| b2DebugDraw.e_pairBit
			;
			
			this._world.SetDebugDraw(dbgDraw);
			
			this._world.SetWarmStarting(true);
		}
		
		public function createBody(bodyDef:b2BodyDef):b2Body
		{
			return this._world.CreateBody(bodyDef);
		}
		
		public function update():void
		{
			this._world.Step(Settings.BOX2D_TIME_STEP, Settings.BOX2D_ITERATIONS);
		}
		
	}

}