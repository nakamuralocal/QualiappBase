package Controllers.Views
{	
	import Events.Oev_ChangeView;
	
	import Singletons.Sig_APP_Master;
	import Singletons.Sig_JSON_Master;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;
	import mx.utils.ObjectUtil;
	
	import spark.components.Group;
	
	public class Vic_ApplyWindow extends EventDispatcher
	{
		public var M_APP:Sig_APP_Master = Sig_APP_Master.getInstance();
		public var M_JSON:Sig_JSON_Master = Sig_JSON_Master.getInstance();
		
		public function Vic_ApplyWindow(target:IEventDispatcher=null)
		{
			super(target);
			
			M_APP.addEventListener(Oev_ChangeView.CHANGE_VIEW , change_View);
		}
		
		public var obj_ViewManager:*;
		public var grp_ViewStage:Group = new Group();
		public var now_View:IVisualElement;
		
		public function change_View(evt:Oev_ChangeView):void
		{
			grp_ViewStage.removeAllElements();
			now_View = new Group();
			
			var change_Class:Class = obj_ViewManager[evt.catch_CallLabel];
			now_View = new change_Class();
			
			grp_ViewStage.addElement(now_View);
		}
		
	}
}