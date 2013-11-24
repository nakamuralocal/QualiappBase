package Events
{
	import flash.events.Event;
	
	public class Oev_FreeAddGroup extends Event
	{
		public static const CHANGE_DATA:String = "change_data";
		
		public var catch_Array:Array = new Array();
		
		public function Oev_FreeAddGroup(type:String,trg_Array:Array,bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			catch_Array = trg_Array;
		}
		
		override public function clone():Event
		{
			return new Oev_FreeAddGroup(type,catch_Array,bubbles, cancelable);
		}  
	}
}