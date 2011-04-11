package WenchWars.Game 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import Box2D.Dynamics.b2Body;
	
	import WenchWars.Game.Physic.Engine;
	import WenchWars.Config.Settings;
	import WenchWars.Game.Model.Repository;
	import WenchWars.Game.Physic.Me.Doll;
	import WenchWars.Tool.Debug.Status;
	
	import WenchWars.Tool.EmbedHandler; 
	import WenchWars.Tool.MovieClipLabelParser;
	
	/**
	 * ...
	 * @author Karl Pannek
	 */
	public class Me
	{
		protected var _standing:Boolean;
		protected var _doll:Doll;
		protected var _mc:MovieClip;
		protected var _currentAnimationState:String = 'stand';
		protected var _lookDirection:Number = 1;
		protected var _moveDirection:Number = 0;
		
		public function Me():void
		{
			this._doll = new Doll();
			this._mc = EmbedHandler.load(EmbedHandler.CHUCK);
			this._mc.stop();
			var mclp:MovieClipLabelParser = new MovieClipLabelParser();
			mclp.parse(this._mc);
			
			Repository.getInstance().createModel(this._mc, this._doll.getBody());
		}
		
		public function getDoll():Doll
		{
			return this._doll;
		}
		
		public function getBody():b2Body
		{
			return this._doll.getBody();
		}
		
		public function setStanding(isStanding:Boolean):void
		{
			if (this._currentAnimationState == 'jump' && !this._standing && isStanding)
			{
				this._animate('stand');
			}
			this._standing = isStanding;
		}
		
		public function isStanding():Boolean
		{
			return this._standing;
		}
		
		public function move(direction:int):void
		{
			this._moveDirection = direction;
			this._doll.move(direction);
			
			if (this._standing && this._currentAnimationState != 'jump')
			{
				this._animate(this._calculateWalkAnimation());
			}
		}
		
		public function stop():void
		{
			this._moveDirection = 0;
			this._doll.stop();
			if (this._isWalking() || this._standing)
			{
				this._animate('stand');
			}
		}
		
		public function preJump():void
		{
		//	if (this._standing && !this._isWalking())
		//	{
		//		this._animate('prejump');
		//	}
		}
		
		public function jump():void
		{
			if (this.isStanding())
			{
				this._doll.jump();
				this._animate('jump');
			}
		}
		
		public function jumping():void
		{
			if (!this.isStanding()) {
				this._doll.jumping();
			}
		}
		
		public function duck():void
		{
			if (this._standing && !this._isWalking())
			{
				this._animate('duck');
			}
		}
		
		public function standUp():void
		{
			if (this._standing)
			{
				this._animate('standup');
			}
		}
		
		protected function _animate(type:String):void
		{
			if (type == this._currentAnimationState)
			{
				return;
			}
			
			this._mc.gotoAndPlay(type);
			
			this._currentAnimationState = type;
		}
		
		protected function _calculateWalkAnimation():String
		{
			if (this._moveDirection == this._lookDirection)
			{
				return 'run';
			} 
			return 'walkback';
		}
		
		public function look(x:Number, y:Number):void
		{
			var degree:Number = Math.atan2(Settings.STAGE_WIDTH / 2 - x, Settings.STAGE_HEIGHT / 2 - 25 - y) / (Math.PI / 180);
			var lastLookDirection:Number = this._lookDirection;
			
			if (x < Settings.STAGE_WIDTH / 2)
			{
				this._mc.scaleX = -1;
				this._lookDirection = -1;
				degree = (-45 + degree / 2);
				this._mc.head.rotation = degree;
			} 
			else if (x >= Settings.STAGE_WIDTH / 2)
			{
				this._mc.scaleX = 1;
				this._lookDirection = 1;
				degree = (45 + -degree / 2) - 90;
				this._mc.head.rotation = degree;
			}
			
			if (this._lookDirection != lastLookDirection && this._isWalking())
			{
				this._animate(this._calculateWalkAnimation());
			}
		}
		
		protected function _isWalking():Boolean
		{
			if (this._currentAnimationState == 'walk' || this._currentAnimationState == 'walkback')
			{
				return true;
			}
			return false;
		}
		
		public function update():void
		{
			this._mc.head.y = this._mc.head_posmask.y;
						
			if (this._doll.getBody().GetLinearVelocity().x == 0 && this._isWalking())
			{
				this.stop();
			}
			
			Status.getInstance('currAnimState').setValue(this._currentAnimationState);
			Status.getInstance('isStanding').setValue(this._standing);
			
			if (!this._doll.getBody().IsSleeping())
			{
				this.setStanding(false);
			}
		}
	}
}