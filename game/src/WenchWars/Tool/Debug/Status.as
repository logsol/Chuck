package WenchWars.Tool.Debug 
{
	import WenchWars.View;
	import WenchWars.Config.Settings;
	import WenchWars.Tool.EmbedHandler;
	
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Karl Pannek
	*/
	public class Status
	{
		protected static var _instances:Array = new Array();
		protected static var _count:int = 0;
		protected var _mc:MovieClip;
		
		public static function getInstance(title:String):Status
		{
			if (!(Status._instances[title] is Status))
			{
				Status._count++;
				Status._instances[title] = new Status(title);
			}
			return Status._instances[title];
		}
		
		public function Status(title:String)
		{	
			/*this._mc = EmbedHandler.load(EmbedHandler.STAT);
			this._mc.title.text = title;
			this._mc.x = Settings.STAGE_WIDTH;
			this._mc.y = Settings.STAGE_HEIGHT - (Status._count-1) * (this._mc.height + 1);
			
			View.getInstance().addToContainer(this._mc);*/
		}
		
		public function setValue(value:*):void
		{
			//this._mc.value.text = String(value);
		}
		
		public function getPosition():Array
		{
			return new Array(0,0);//new Array(this._mc.x, this._mc.y);
		}
	}

}