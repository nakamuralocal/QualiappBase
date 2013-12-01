package Events
{
	import flash.events.Event;
	
	public class Oev_ErrorView extends Event
	{
		public static const ERROR_VIEW:String = "error_view";
		
		public var catch_ErrorCode:String = new String();
		public var catch_ErrorMSG:String = new String();
		
		public function Oev_ErrorView(type:String,
									  trg_ErrorCode:String,
									  trg_ErrorMSG:String,
									  bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			catch_ErrorCode = trg_ErrorCode;
			catch_ErrorMSG = trg_ErrorMSG;
		}
		
		override public function clone():Event
		{
			return new Oev_ErrorView(type,catch_ErrorCode,catch_ErrorMSG,bubbles, cancelable);
		}  
	}
}