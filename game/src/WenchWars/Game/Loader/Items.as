package WenchWars.Game.Loader
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.xml.XMLDocument;
	import flash.display.Loader;
	import flash.display.DisplayObject;
	
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	
	import WenchWars.Tool.TextFileHandler;
	import WenchWars.Tool.DisplayFileHandler;
	import WenchWars.Config.Settings;
	import WenchWars.Game.Processor;
	import WenchWars.Game.Model.Repository;
	import WenchWars.Game.Physic.Engine;
	
	import WenchWars.Tool.Debug.*;
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
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.position.x = 150 / Settings.RATIO; //Math.round(Math.random() * Settings.STAGE_WIDTH) / Settings.RATIO;
			bodyDef.position.y = 0;
			bodyDef.angle = Math.random() * 360 / 180 * Math.PI;

			var body:b2Body = Processor.getInstance().getEngine().createBody(bodyDef);
			
			var itemShape:b2PolygonShape = new b2PolygonShape();
			itemShape.SetAsBox(file.width / 2 / Settings.RATIO, file.height / 2 / Settings.RATIO);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = itemShape;
			fixtureDef.density = Settings.ITEM_DENSITY;
			fixtureDef.friction = Settings.ITEM_FRICTION;
			fixtureDef.restitution = Settings.ITEM_RESTITUTION;
			fixtureDef.isSensor = false;
			fixtureDef.userData = 'item';
			body.CreateFixture(fixtureDef);
			
			file.x = -file.width / 2;
			file.y = -file.height / 2;
			var graphic:Sprite = new Sprite();
			graphic.addChild(DisplayObject(file));
			
			Repository.getInstance().createModel(graphic, body);
		}
	}
}