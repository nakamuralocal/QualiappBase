package Events
{
	import flash.events.Event;
	
	public class Oev_FreeAddItem extends Event
	{
		public static const REG_ITEM:String = "reg_item";
		public static const UNREG_ITEM:String = "unreg_item";
		public static const CHANGE_TEXT_DATA:String = "change_text_data";
		
		public var catch_IndexNum:uint = new uint();
		
		public function Oev_FreeAddItem(type:String,trg_IndexNum:uint,bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			catch_IndexNum = trg_IndexNum;
		}
		
		override public function clone():Event
		{
			return new Oev_FreeAddItem(type,catch_IndexNum,bubbles, cancelable);
		}  
	}
}