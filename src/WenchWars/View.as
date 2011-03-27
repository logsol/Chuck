package WenchWars 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class View
	{
		protected static var instance:View = null;
		
		protected var _stage:Stage;
		protected var _container:Sprite = new Sprite();
		protected var _sprite:Sprite = new Sprite();
		
		public static function getInstance():View
		{
			if (View.instance === null)
			{
				View.instance = new View();
			}
			return View.instance;
		}
	
		public function View()
		{
			
		}
		
		public function init(stage:Stage):void
		{
			this._stage = stage;
			this._stage.addChild(this._container);
			this._container.addChild(this._sprite);			
		}
		
		public function refreshSprite():void
		{
			this._container.removeChild(this._sprite);
			this._sprite = new Sprite();
			this._container.addChild(this._sprite);
		}
		
		public function getSprite():Sprite
		{
			return this._sprite;
		}
		
		public function getStage():Stage
		{
			return this._stage;
		}
			
		public function add(object:*):void
		{
			this._sprite.addChild(object);
		}
			
		public function addToContainer(object:*):void
		{
			this._container.addChild(object);
		}
	}
}