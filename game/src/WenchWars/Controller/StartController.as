package WenchWars.Controller 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import WenchWars.Controller;
	import WenchWars.View;
	/**
	 * ...
	 * @author Karl Pannek
	 */ 
	public class StartController extends AbstractController 
	{
		
		public function StartController() 
		{
		}
		
		override public function display():void
		{
			var rect:Shape = new Shape();
			rect.graphics.lineStyle(100, 0xFF5500);
			rect.graphics.drawRect(100, 100, 100, 100);
			
			this._view.add(rect);
			
			this._view.getSprite().addEventListener(MouseEvent.MOUSE_DOWN, this.klikk);
		}
		
		public function klikk(e:MouseEvent):void
		{
			Controller.getInstance().select('game');
		}
	}

}