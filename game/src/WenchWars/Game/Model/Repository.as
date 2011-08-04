package WenchWars.Game.Model 
{
	import flash.geom.Matrix;
	import flash.display.DisplayObject;
	
	import Box2D.Dynamics.b2Body;
	
	import WenchWars.View;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class Repository 	
	{
		protected static var instance:Repository = null;
		protected var _models:Array = new Array();
		
		public static function getInstance():Repository
		{
			if (Repository.instance === null)
			{
				Repository.instance = new Repository();
			}
			return Repository.instance;
		}
		
		public function Repository() 
		{
			
		}
		
		public function createModel(graphic:DisplayObject, body:b2Body):void
		{
			var model:Model = new Model(graphic, body)
			this._models.push(model);
			View.getInstance().add(graphic);
		}
		
		
		public function update():void
		{
			for each(var model:Model in this._models)
			{
				model.update();
			}
		}	
	}
}