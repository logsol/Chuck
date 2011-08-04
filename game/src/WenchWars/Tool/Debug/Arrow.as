package WenchWars.Tool.Debug 
{
	import WenchWars.View;
	
	import flash.display.MovieClip;
	import WenchWars.Tool.EmbedHandler;
	
	/**
	 * ...
	 * @author Karl Pannek
	*/
	public class Arrow
	{
		protected static var _instances:Array = new Array();
		protected var _mc:MovieClip;
		
		public static function getInstance(id:Number):Arrow
		{
			if (!(Arrow._instances[id] is Arrow))
			{
				Arrow._instances[id] = new Arrow(id);
			}
			return Arrow._instances[id];
		}
		
		public function Arrow(id:Number)
		{
			switch(id)
			{
				case 1: 
					this._mc = EmbedHandler.load(EmbedHandler.ARROW1);
				  break;
				  
				case 2: 
					this._mc = EmbedHandler.load(EmbedHandler.ARROW2);
				  break;
				
				case 3: 
					this._mc = EmbedHandler.load(EmbedHandler.ARROW3);
				  break;
				
				case 4: 
					this._mc = EmbedHandler.load(EmbedHandler.ARROW4);
				  break;
			}
			
			View.getInstance().add(this._mc);
			this._mc.x = 100 * id;
			this._mc.y = 150;
		}
		
		public function setPosition(x, y)
		{
			this._mc.x = x;
			this._mc.y = y;
		}
		
		public function getPosition()
		{
			return new Array(this._mc.x, this._mc.y);
		}
	}

}