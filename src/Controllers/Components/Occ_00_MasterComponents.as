package Controllers.Components
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Occ_00_MasterComponents extends EventDispatcher
	{
		public function Occ_00_MasterComponents(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function add_BtnFunction():void
		{
			
		}
		
		public function remove_BtnFunction():void
		{
			
		}
		
		public function exit_View():void
		{
			remove_BtnFunction();
		}
	}
}