package WenchWars.Config
{
	import flash.system.Security;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class Settings
	{
		// GENERAL
		public static const STAGE_WIDTH:Number = 550;
		public static const STAGE_HEIGHT:Number = 400;
		
		// BOX2D INITIALATORS
		public static const RATIO:Number = 35;
		public static const BOX2D_WORLD_AABB_SIZE:int = 3000;
		public static const BOX2D_ALLOW_SLEEP:Boolean = true;
		public static const BOX2D_GRAVITY:int = 16;
		public static const BOX2D_VELOCITY_ITERATIONS:int = 5;
		public static const BOX2D_POSITION_ITERATIONS:int = 5;
		public static const BOX2D_TIME_STEP:Number = 1 / 30;
		
		// GRAPHIC PATHS
		public static const GRAPHICS_PATH:String = 'img';
		public static const GRAPHICS_SUBPATH_ITEMS:String = 'Items';
		public static const GRAPHICS_SUBPATH_CHARACTERS:String = 'Characters';
		
		public static const TILE_SIZE:int = 15;
		
		// GAME PLAY 
		public static const WALK_SPEED:Number = 2.5;
		public static const RUN_SPEED:Number = 4.0;
		public static const FLY_SPEED:Number = 3.2;
		public static const JUMP_SPEED:Number = 3.0;
		
		// restitution = bouncyness, friction = rubbing, density = mass
		public static const TILE_FRICTION:Number = 0.99;
		public static const TILE_RESTITUTION:Number = 0.1;
		
		public static const PLAYER_DENSITY:Number = 0.96;
		public static const PLAYER_FRICTION:Number = 5;
		public static const PLAYER_MOTION_FRICTION:Number = 0;
		public static const PLAYER_RESTITUTION:Number = 0.0;
		public static const PLAYER_LINEAR_DAMPING:Number = .5;
		
		
		public static const ITEM_DENSITY:Number = 0.9;
		public static const ITEM_FRICTION:Number = 0.99;
		public static const ITEM_RESTITUTION:Number = 0.02;

	}
}