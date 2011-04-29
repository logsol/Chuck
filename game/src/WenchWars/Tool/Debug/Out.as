package WenchWars.Tool.Debug
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import WenchWars.View;
	
	/**
	 * ...
	 * @author Karl Pannek
	 */
		
	public class Out
	{
		protected static var field:TextField = null;
		
		public static function put(output:*):void
		{
			Out.createField();
            Out.field.appendText("- " + output.toString() + "\n");
		}
		
		public static function pad(output:*):void
		{
			Out.createField();
			Out.field.text = output.toString();
		}
		
		public static function push(output:*):void
		{
			Out.createField();
			Out.field.appendText(output.toString() + " | ");
		}
		
		private static function createField():void
		{
			if(!Out.field)
			{
				Out.field = new TextField();
				Out.field.border = true;
				Out.field.textColor = 0xffcc00;
				Out.field.borderColor = 0x994400;
				Out.field.width = 300;
				
        	    var format1:TextFormat = new TextFormat();
			    format1.font="Arial";
			    format1.size=12;
			    Out.field.defaultTextFormat = format1;
			    //Out.field.setTextFormat(format1);
				
				View.getInstance().addToContainer(Out.field);
			}
		}
	}
}