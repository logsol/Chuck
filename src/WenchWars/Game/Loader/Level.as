package WenchWars.Game.Loader 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.xml.XMLDocument;
	
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	
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
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.x = x / Settings.RATIO;
			bodyDef.position.y = y / Settings.RATIO;
			bodyDef.angle = rotation * 90 * Math.PI / 180;
		
			var shapeDef:b2PolygonDef = new b2PolygonDef();
			
			switch(shape)
			{
				case 1:
					shapeDef.vertexCount = 4;
					shapeDef.vertices[0].Set(-tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //  o o o
					shapeDef.vertices[1].Set( tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //  o o o
					shapeDef.vertices[2].Set( tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o o
					shapeDef.vertices[3].Set(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);
				  break;
				  
				case 2:
					shapeDef.vertexCount = 3;
					shapeDef.vertices[0].Set(-tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //  o
					shapeDef.vertices[1].Set( tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o  
					shapeDef.vertices[2].Set(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o o
				  break;
				  
				case 3:
					shapeDef.vertexCount = 3;
					shapeDef.vertices[0].Set(-tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //  o
					shapeDef.vertices[1].Set( 0,                              tileSize / 2 / Settings.RATIO);  //  o 
					shapeDef.vertices[2].Set(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o
				  break;
				  
				case 4:
					shapeDef.vertexCount = 4;
					shapeDef.vertices[0].Set(-tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //  o 
					shapeDef.vertices[1].Set( tileSize / 2 / Settings.RATIO, 0                             );  //  o o o 
					shapeDef.vertices[2].Set( tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o o 
					shapeDef.vertices[3].Set(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);
				  break;
				  
				  case 5:
					shapeDef.vertexCount = 3;
					shapeDef.vertices[0].Set( tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //      o
					shapeDef.vertices[1].Set( tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //      o
					shapeDef.vertices[2].Set( 0                            ,  tileSize / 2 / Settings.RATIO);  //    o o
				  break;
				  
				case 6:
					shapeDef.vertexCount = 4;
					shapeDef.vertices[0].Set( tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);  //      o
					shapeDef.vertices[1].Set( tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o o
					shapeDef.vertices[2].Set(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o o
					shapeDef.vertices[3].Set(-tileSize / 2 / Settings.RATIO,  0                   );
				  break;
				  
				case 7:
					shapeDef.vertexCount = 3;
					shapeDef.vertices[0].Set(-tileSize / 2 / Settings.RATIO,  0                            );  //        
					shapeDef.vertices[1].Set( 0                            ,  tileSize / 2 / Settings.RATIO);  //  o    
					shapeDef.vertices[2].Set(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);  //  o o      
				  break;
				 
				case 8:
					shapeDef.vertexCount = 5;
					shapeDef.vertices[0].Set(-tileSize / 2 / Settings.RATIO, -tileSize / 2 / Settings.RATIO);//  o o   
					shapeDef.vertices[1].Set( 0                          , -tileSize / 2 / Settings.RATIO);  //  o o o  
					shapeDef.vertices[2].Set( tileSize / 2 / Settings.RATIO,  0                          );  //  o o o    
					shapeDef.vertices[3].Set( tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);   
					shapeDef.vertices[4].Set(-tileSize / 2 / Settings.RATIO,  tileSize / 2 / Settings.RATIO);   
				  break;
				  
				default:
				  break;
			}

			shapeDef.density = 0; //STIFF
			shapeDef.friction = Settings.TILE_FRICTION;
			shapeDef.restitution = Settings.TILE_RESTITUTION;
			shapeDef.userData = 'tileWorld';
			
			var body:b2Body = Processor.getInstance().getEngine().createBody(bodyDef);
			body.CreateShape(shapeDef);
			body.SetMassFromShapes();
			
		}
	}

}