package Singletons
{
	import Events.Oev_ChangeView;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Sig_APP_Master extends EventDispatcher
	{
		public function change_View(trg_CallLabel:String):void
		{
			dispatchEvent(new Oev_ChangeView(Oev_ChangeView.CHANGE_VIEW , trg_CallLabel));
		}
		
		private static var _instance:Sig_APP_Master;
		
		public function Sig_APP_Master(privateClass:PrivateClass,target:IEventDispatcher=null)
		{
			super(target);
		}

		public static function getInstance():Sig_APP_Master {
			if (!_instance) {
				_instance = new Sig_APP_Master(new PrivateClass,null);
			}
			return _instance;
		}
	}
}

class PrivateClass {
}