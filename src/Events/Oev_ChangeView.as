package Events
{
	import flash.events.Event;
	
	public class Oev_ChangeView extends Event
	{
		public static const CHANGE_VIEW:String = "change_view";
		
		public var catch_CallLabel:String = new String();
		
		public function Oev_ChangeView(type:String,trg_CallLabel:String,bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			catch_CallLabel = trg_CallLabel;
		}
		
		override public function clone():Event
		{
			return new Oev_ChangeView(type,catch_CallLabel,bubbles, cancelable);
		}  
	}
}