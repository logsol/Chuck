/*
 Copyright (c) 2007-2009 Paulius Uza  <paulius@uza.lt> and InRuntime Ltd. <hello@inruntime.com>
  
 Permission is hereby granted, free of charge, to any person obtaining a copy 
 of this software and associated documentation files (the "Software"), to deal 
 in the Software without restriction, including without limitation the rights 
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished 
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all 
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
 PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

@ignore
*/

package com.inruntime.utils
{
	
	import flash.utils.*;
	import flash.events.*;
	
	public dynamic class Global extends Proxy implements IEventDispatcher
	{


		/**
		 *  //GLOBAL OBJECT CLASS
		 *  //EXAMPLE USAGE (in any other class):
		 * 
		 *  private var global:Global = Global.getInstance();
		 *
		 *  global.testVariableA = "hello";
		 *  global.anyClass = new Sprite();
		 *  trace(testVariableA);
		 *
		 *  //you can aso "watch" variables:
		 *  
		 *  global.addEventListener(GlobalEvent.PROPERTY_CHANGED,onPropChanged);
		 *  global.variable = 1;
		 *  global.variable = 2;
		 * 
		 *  private function onPropChanged(e:GlobalEvent):void {
				trace ("property "+ e.property + " has changed to " + global[e.property]);
			} 
		 * 
		 */

		private static var instance:Global = null;
		private static var allowInstantiation:Boolean = false;
		private var globalRepository:GlobalHashMap;
		private var dispatcher:EventDispatcher;
		
		/**
		 * Returns the single global instance of this class.
		 */
		
		public static function getInstance() : Global {
			if ( Global.instance == null ) {
				Global.allowInstantiation = true;
				Global.instance = new Global();
				Global.allowInstantiation = false;
			}
			return Global.instance;
		}
		
		/**
		 * Singleton constructor. Use <code>Global.getInstance();</code> instead.
		 */
		
		public function Global() {
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use Global.getInstance() instead of new Global().");
			} else {
				globalRepository = new GlobalHashMap();
				dispatcher = new EventDispatcher(this);
			}
		}
 	 	
 	 	override flash_proxy function callProperty(methodName:*, ... args):* {
	        var result:*;
	       	switch (methodName.toString()) {
	            default:
	                result = globalRepository.getValue(methodName).apply(globalRepository, args);
	            break;
	        }
	        return result;
	    }
	    
 	 	override flash_proxy function getProperty(name:*):* {
		    return globalRepository.getValue(name);
		}
		
		override flash_proxy function setProperty(name:*, value:*):void {
			var oldValue = globalRepository.getValue(name);
			globalRepository.put(name , value);
			
			if(oldValue !== value) {
				dispatchEvent(new GlobalEvent(GlobalEvent.PROPERTY_CHANGED,name));
			}
		}
		
		public function get length():int {
	    	var retval:int = globalRepository.size();
	    	return retval;
	    }
	    
	    public function containsValue(value:*):Boolean{
	    	var retval:Boolean = globalRepository.containsValue(value);
	   		return retval;
	    }
	    
	   	public function containsKey(name:String):Boolean{
	    	var retval:Boolean = globalRepository.containsKey(name);
	   		return retval;
	    }
	    
	   	public function put(name:String, value:*):void {
	    	globalRepository.put(name,value);
	    }
	    
	    public function take(name:*):* {
	    	return globalRepository.getValue(name);
	    }
	    
	    public function remove(name:String):void {
	    	globalRepository.remove(name);
	    }
	    
	    public function toString():String {
	    	var temp:Array = new Array();
	    	for (var key:* in globalRepository) {
	    		temp.push ("{" + key + ":" + globalRepository[key] + "}");
	    	}
	    	return temp.join(",");
	    }
	    
	    /**
	    *   Event Dispatcher Functions
	    */
	    
	    public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void{
        	dispatcher.addEventListener(type, listener, useCapture, priority);
	    }
	           
	    public function dispatchEvent(evt:Event):Boolean{
	        return dispatcher.dispatchEvent(evt);
	    }
	    
	    public function hasEventListener(type:String):Boolean{
	        return dispatcher.hasEventListener(type);
	    }
	    
	    public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void{
	        dispatcher.removeEventListener(type, listener, useCapture);
	    }
	                   
	    public function willTrigger(type:String):Boolean {
	        return dispatcher.willTrigger(type);
	    }
	}
}

import flash.utils.Dictionary;

/**
 * Hash map implementation which dynamically creates a GlobalHashMap of 
 * key and value pairs.
 */

dynamic class GlobalHashMap extends Dictionary
{
	/**
	 * By default, weak key references are used in order to ensure
	 * that objects are eligible for Garbage Collection
	 * 
	 * @param  specifies if weak key references should be used
	 */        
	public function GlobalHashMap(useWeakReferences:Boolean = true)
	{
		super(useWeakReferences);
	}
	
	/**
	 * Adds a key / value to the current Map
	 * 
	 * @param the key to add to the map
	 * @param the value of the specified key
	 */
	public function put(key:String, value:*):void
	{
		this[key] = value;    
	}
	
	/**
	 * Removes a key / value from the current Map
	 * 
	 * @param the key to remove from the map
	 */
	public function remove(key:String):void
	{
		this[key] = null;
	}
	
	/**
	 * Determines if a key exists in the current map
	 * 
	 * @param  the key in which to determine existance in the map
	 * @return true if the key exisits, false if not
	 */
	public function containsKey(key:String):Boolean
	{
		return this[key] != null
	}
	
	/**
	 * Determines if a value exists in the current map
	 * 
	 * @param  the value in which to determine existance in the map
	 * @return true if the value exisits, false if not
	 */
	public function containsValue(value:*):Boolean
	{
		for (var prop:String in this) {
			
			if (this[prop] == value)
			{
				return true
			}
		}
		return false;
	}
	
	/**
	 * Returns a key value from the current Map
	 * 
	 * @param  the key in which to retrieve the value of
	 * @return the value of the specified key
	 */
	public function getKey(value:*):String
	{
		for (var prop:String in this) {
			
			if (this[prop] == value)
			{
				return prop
			}
		}
		return null;
	}
	
	/**
	 * Returns a key value from the current Map
	 * 
	 * @param  the key in which to retrieve the value of
	 * @return the value of the specified key
	 */
	public function getValue(key:String):*
	{
		if (this[key] != null)
		{
			return this[key];
		}
	}
	
	/**
	 * Returns the size of this map
	 * 
	 * @return the current size of the map instance
	 */
	public function size():int
	{
		var size:int = 0;
		
		for (var prop:String in this) {
			
			if (this[prop] != null)
			{
				size++;
			}        
		}
		return size;
	}
	
	/**
	 * Determines if the current map is empty
	 * 
	 * @return true if the current map is empty, false if not
	 */
	public function isEmpty():Boolean
	{
		var size:int = 0;
		
		for (var prop:String in this) {
			
			if (this[prop] != null)
			{
				size++;
			}    
		}    
		return size <= 0;
	}
	
	/**
	 * Resets all key / values in map to null
	 */
	public function clear():void
	{
		for (var prop:String in this) {    
			
			this[prop] = null;
		}
	}
}