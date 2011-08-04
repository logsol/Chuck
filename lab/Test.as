﻿package
{	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.external.ExternalInterface;
	
	import Out;
	
	import CustomSocket;
	
	
	[SWF( frameRate="30", backgroundColor="0x222222", width="550", height="400" )]
	public class Test extends Sprite
	{	
		public function Test()
		{
			Out.init(stage);
			
			try {
				var socket:CustomSocket = new CustomSocket("localhost", 6937);
			} catch(e:*) {
				Out.put(e);
			}
		}	
	}
}