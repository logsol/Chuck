package WenchWars.Game.Loader 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.xml.XMLDocument;
	
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Common.Math.b2Vec2;
	
	import WenchWars.Tool.TextFileHandler;
	import WenchWars.Config.Settings;
	import WenchWars.Game.Processor;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class Level
	{
		public function Level():void 
		{
			this.load()
		}
		
		public function load():void
		{
			var file:TextFileHandler = new TextFileHandler();
			file.load('level.xml', this.process);
		}
		
		public function process(file:String):void
		{			
			var result:XMLDocument = new XMLDocument();
			result.ignoreWhite = true;
			result.parseXML(file);
						
			var objects:Array = result.firstChild.firstChild.childNodes;
			for (var i:Number = 0; i < objects.length; i++)
			{
				this.createPhysicTile(objects[i].attributes.shape, objects[i].attributes.x * Settings.TILE_SIZE, objects[i].attributes.y * Settings.TILE_SIZE, int(objects[i].attributes.rotation));
			}
		}
		
		public function generateAllTiles():void
		{
			// GENERATING ALL POSSIBLE TILE SHAPES
			var xpos:Number= 185;
			var ypos:Number = 150;
			var space:Number = 0;
			
			for (var i:Number = 0; i < 8; i++)
			{
				for (var r:Number = 0; r < 4; r++)
				{
					this.createPhysicTile(i+1, xpos + r * (Settings.TILE_SIZE + space), ypos + i * (Settings.TILE_SIZE + space), r);
				}
			}
		}
		
		
		public function createPhysicTile(shape:Number, x:Number, y:Number, rotation:Number = 0):void
		{
			var tileSize:Number = Settings.TILE_SIZE;
			var vertices:Array = new Array();
			
			switch(shape)
			{
				case 1:
					vertices[0] = new b2Vec2(-tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //  o o o
					vertices[1] = new b2Vec2( tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //  o o o
					vertices[2] = new b2Vec2( tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o o
					vertices[3] = new b2Vec2(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);
				  break;
				  
				case 2:
					vertices[0] = new b2Vec2(-tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //  o
					vertices[1] = new b2Vec2( tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o  
					vertices[2] = new b2Vec2(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o o
				  break;
				  
				case 3:
					vertices[0] = new b2Vec2(-tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //  o
					vertices[1] = new b2Vec2( 0,                              tileSize / 2 / Settings.RATIO);  //  o 
					vertices[2] = new b2Vec2(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o
				  break;
				  
				case 4:
					vertices[0] = new b2Vec2(-tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //  o 
					vertices[1] = new b2Vec2( tileSize / 2 / Settings.RATIO, 0                             );  //  o o o 
					vertices[2] = new b2Vec2( tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o o 
					vertices[3] = new b2Vec2(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);
				  break;
				  
				  case 5:
					vertices[0] = new b2Vec2( tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //      o
					vertices[1] = new b2Vec2( tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //      o
					vertices[2] = new b2Vec2( 0                            ,  tileSize / 2 / Settings.RATIO);  //    o o
				  break;
				  
				case 6:
					vertices[0] = new b2Vec2( tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //      o
					vertices[1] = new b2Vec2( tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o o
					vertices[2] = new b2Vec2(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o o
					vertices[3] = new b2Vec2(-tileSize / 2 / Settings.RATIO,  0                   );
				  break;
				  
				case 7:
					vertices[0] = new b2Vec2(-tileSize / 2 / Settings.RATIO,  0                            );  //        
					vertices[1] = new b2Vec2( 0                            ,  tileSize / 2 / Settings.RATIO);  //  o    
					vertices[2] = new b2Vec2(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o      
				  break;
				 
				case 8:
					vertices[0] = new b2Vec2(-tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);//  o o   
					vertices[1] = new b2Vec2( 0                            , -tileSize / 2 / Settings.RATIO);//  o o o  
					vertices[2] = new b2Vec2( tileSize / 2 / Settings.RATIO,  0                          );  //  o o o    
					vertices[3] = new b2Vec2( tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);   
					vertices[4] = new b2Vec2(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);   
				  break;
				  
				default:
				  break;
			}
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.position.x = x / Settings.RATIO;
			bodyDef.position.y = y / Settings.RATIO;
			bodyDef.angle = rotation * 90 * Math.PI / 180;
		
			var tileShape:b2PolygonShape = new b2PolygonShape();
			tileShape.SetAsArray(vertices, vertices.length);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = tileShape;
			fixtureDef.density = 0;
			fixtureDef.friction = Settings.TILE_FRICTION;
			fixtureDef.restitution = Settings.TILE_RESTITUTION;
			fixtureDef.isSensor = false;
			fixtureDef.userData = 'tile';

			var body:b2Body = Processor.getInstance().getEngine().createBody(bodyDef);
			body.CreateFixture(fixtureDef);
		}
	}
}