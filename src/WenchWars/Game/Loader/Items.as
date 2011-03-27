package WenchWars.Game.Loader
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.xml.XMLDocument;
	import flash.display.Loader;
	import flash.display.DisplayObject;
	
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonDef;
	
	import WenchWars.Tool.TextFileHandler;
	import WenchWars.Tool.DisplayFileHandler;
	import WenchWars.Config.Settings;
	import WenchWars.Game.Processor;
	import WenchWars.Game.Model.Repository;
	import WenchWars.Game.Physic.Engine;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class Items
	{
		
		public function Items():void 
		{
			var file:TextFileHandler = new TextFileHandler();
			file.load('items.xml', this.process);
		}
		
		public function process(file:String):void
		{	
			var result:XMLDocument = new XMLDocument();
			result.ignoreWhite = true;
			result.parseXML(file);
			
			var items:Array = result.firstChild.childNodes;
			for (var i:Number = 0; i < items.length; i++)
			{
				var hand:DisplayFileHandler = new DisplayFileHandler();
				
				hand.load(
					Settings.GRAPHICS_PATH + '/' 
					+ Settings.GRAPHICS_SUBPATH_ITEMS + '/' 
					+ items[i].attributes.category + '/'
					+ items[i].attributes.image , this.processBox);
			}
		}
		
		public function processBox(file:Loader):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.x = 150 / Settings.RATIO; //Math.round(Math.random() * Settings.STAGE_WIDTH) / Settings.RATIO;
			bodyDef.position.y = 0;
			bodyDef.angle = Math.random() * 360 / 180 * Math.PI;
			
			// Box
			var shapeDef:b2PolygonDef = new b2PolygonDef();
			shapeDef.SetAsBox(file.width / 2 / Settings.RATIO, file.height / 2 / Settings.RATIO);
			shapeDef.density = Settings.ITEM_DENSITY;
			shapeDef.friction = Settings.ITEM_FRICTION;
			shapeDef.restitution = Settings.ITEM_RESTITUTION;
			shapeDef.userData = 'Item';
			
			var body:b2Body = Processor.getInstance().getEngine().createBody(bodyDef);
			body.CreateShape(shapeDef);
			body.SetMassFromShapes();
			
			file.x = -file.width / 2;
			file.y = -file.height / 2;
			var graphic:Sprite = new Sprite();
			graphic.addChild(DisplayObject(file));
			
			Repository.getInstance().createModel(graphic, body);
		}
	}
}