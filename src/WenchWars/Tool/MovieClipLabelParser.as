package WenchWars.Tool 
{
	import flash.display.MovieClip;
	import flash.display.FrameLabel;
	import flash.events.Event;
	
	import WenchWars.View;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Karl Pannek
	 */
		
	public class MovieClipLabelParser
	{
		private var registry:Array;
		
		public function parse(target:MovieClip):void
		{
			var labels:Array = target.currentLabels;
			var temp:Object;
			var parts:Array;
			/*
			for each (var frameLabel:FrameLabel in labels)
			{
				if(frameLabel.name.substr(0,1) == '*')
				{	
					parts = frameLabel.name.substr(1,0);//.split(":");
					
					temp = {
						frame: frameLabel.frame,
						action: parts[0]
						//parameter: parts[1]
					};
					
					this.registry[frameLabel.frame] = temp;
					
					temp = null;
				} 
				
			var result:TextField = new TextField();
            result.x = 100; 
            result.y = 100;
            result.width = 300; 
            result.height = 100;
			result.text = this.registry.toString();
            View.getInstance().addToContainer(result);
			}
			*/
			//target.addEventListener(Event.ENTER_FRAME, this.update);
		}
	}
}