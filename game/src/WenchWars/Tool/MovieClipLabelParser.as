	package WenchWars.Tool 
{
	import flash.display.MovieClip;
	import flash.display.FrameLabel;
	import flash.events.Event;
	
	import WenchWars.View;
	/**
	 * ...
	 * @author Karl Pannek
	 */
		
	public class MovieClipLabelParser
	{
		// todo: has to be multidimensional, in order to work for multiple mcs
		private var registry:Array = new Array();
		
		public function parse(target:MovieClip):void
		{
			var labels:Array = target.currentLabels;
			
			for each (var frameLabel:FrameLabel in labels)
			{
				
				if(frameLabel.name.substr(0,1) == '*')
				{	
					var output:Array = frameLabel.name.substr(1).split(":");

					output[1] = output[1] ? output[1] : null;
					
					var temp:Object = {
						frame: frameLabel.frame,
						action: output[0].substr(0, 4),
						parameter: output[1]
					};
					
					this.registry[frameLabel.frame] = temp;
				} 
			}
			
			target.addEventListener(Event.ENTER_FRAME, this.update);
		}
		
		protected function update(evt:Event):void
		{
			if(this.registry[evt.target.currentFrame])
			{
				switch(this.registry[evt.target.currentFrame].action)
				{	
					case 'stop': 
						evt.target.stop();
						break;
						 
					case 'gtap': 
						evt.target.gotoAndPlay(this.registry[evt.target.currentFrame].parameter);
						break;
						
					case 'gtap': 
						evt.target.gotoAndStop(this.registry[evt.target.currentFrame].parameter);
						break;
				}
			}
		}
	}
}