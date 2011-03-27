package WenchWars.Tool 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Jeena Paradies
	 */
		
	public class EmbedHandler
	{
		public static const CHUCK:Number = 0;
		public static const STAT:Number = 1;
		public static const ARROW1:Number = 2;
		public static const ARROW2:Number = 3;
		public static const ARROW3:Number = 4;
		public static const ARROW4:Number = 5;
		
		public static function load(linkageId:Number):MovieClip
		{
			
			switch (linkageId)
			{
				case CHUCK:
					[Embed(source="../../../WenchWars.swf", symbol="MC_Chuck")]
					var chuck:Class;
					return new chuck();
					
				case STAT:
					[Embed(source="../../../WenchWars.swf", symbol="MC_Status")]
					var a_status:Class;
					return new a_status();

				case ARROW1:
					[Embed(source="../../../WenchWars.swf", symbol="MC_Arrow1")]
					var arrow1:Class;
					return new arrow1();

				case ARROW2:
					[Embed(source="../../../WenchWars.swf", symbol="MC_Arrow2")]
					var Arrow2:Class;
					return new Arrow2();
				
				case ARROW3:
					[Embed(source="../../../WenchWars.swf", symbol="MC_Arrow3")]
					var Arrow3:Class;
					return new Arrow3();

				case ARROW4:
					[Embed(source="../../../WenchWars.swf", symbol="MC_Arrow4")]
					var Arrow4:Class;
					return new Arrow4();

				default:
					throw new Error("No such linkageId " + linkageId.toString());
				
			}
		}
	}
}