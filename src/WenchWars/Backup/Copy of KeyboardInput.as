package WenchWars.Game.Control 
{
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.display.Sprite;
	
	import WenchWars.Game.Processor;
	import WenchWars.View;
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class KeyboardInput
	{
		protected var pressedKeys:Array = new Array();
		protected var icu:InputControlUnit;
		
		public function KeyboardInput(icu:InputControlUnit):void 
		{	
			this.icu = icu;
			View.getInstance().getStage().addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			View.getInstance().getStage().addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
			View.getInstance().getStage().addEventListener(Event.ENTER_FRAME, this.run);
		}
		
		protected function onKeyDown(e:KeyboardEvent):void
		{
			
			if (e.keyCode == 17)
			{
				//var controller:Controller = Controller.getInstance();
				//controller.select('game');
				return;
			}
			
			var check:Boolean = false;
			for (var i:int = 0; i < this.pressedKeys.length; i++ )
			{
				if (this.pressedKeys[i] == e.keyCode)
				{
					check = true;
					break;
				}
			}
			
			if (check == false)
			{
				this.pressedKeys.push(e.keyCode);
			}
		}
		
		protected function onKeyUp(e:KeyboardEvent):void
		{
			var tempArray:Array = new Array();
			for (var i:int = 0; i < this.pressedKeys.length; i++ )
			{
				if (this.pressedKeys[i] != e.keyCode)
				{
					tempArray.push(this.pressedKeys[i]);
				}
			}
			this.pressedKeys = tempArray;
				
			switch(e.keyCode)
			{
				case 87: 
					this.icu.jump();
				  break;
				  
				case 83: 
					this.icu.standUp();
				  break
			}
			
			//trace(e.keyCode);
			
			var check:Boolean = false;
			for ( i = 0; i < this.pressedKeys.length; i++ )
			{
				if (this.pressedKeys[i] == 65 || this.pressedKeys[i] == 68)
				{
					check = true;
				}
			}
			if (check == false)
			{
				this.icu.stop();
			}
		}
		
		protected function run(e:Event):void
		{
			for (var i:int = 0; i < this.pressedKeys.length; i++ )
			{
				switch(this.pressedKeys[i])
				{
					//case 37:
					case 65:
						
						this.icu.move(-1)
						break;
						
					//case 39:
					case 68:
						this.icu.move(1)
						break;
						
					//case 38:
					case 87:
						this.icu.preJump()
						trace('pj');
						break;
						
					//case 40:
					case 83:
						this.icu.duck()
						break;
					
					default:
						break;
				}
			}
		}
	}
}