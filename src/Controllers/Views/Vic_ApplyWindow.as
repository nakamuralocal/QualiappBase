package Controllers.Views
{	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.controls.Label;
	import mx.core.IVisualElement;
	
	import spark.components.Group;
	
	import Events.Oev_ChangeView;
	import Events.Oev_ErrorView;
	
	import Singletons.Sig_APP_Master;
	import Singletons.Sig_JSON_Master;
	
	import avmplus.getQualifiedClassName;
	
	public class Vic_ApplyWindow extends EventDispatcher
	{
		public var M_APP:Sig_APP_Master = Sig_APP_Master.getInstance();
		public var M_JSON:Sig_JSON_Master = Sig_JSON_Master.getInstance();
		
		public function Vic_ApplyWindow(target:IEventDispatcher=null)
		{
			super(target);
			
			M_APP.addEventListener(Oev_ChangeView.CHANGE_VIEW , change_View);
			M_APP.addEventListener(Oev_ErrorView.ERROR_VIEW , error_View);
			
			grp_ErrorStage.visible = false;
			
			lab_ErrorCode.setStyle("color",0xFFFFFF);
			lab_ErrorCode.setStyle("fontSize",32);
			lab_ErrorCode.horizontalCenter = 0;
			lab_ErrorCode.verticalCenter = -60;
			
			lab_ErrorMsg.setStyle("color",0xFFFFFF);
			lab_ErrorMsg.setStyle("fontSize",18);
			lab_ErrorMsg.horizontalCenter = 0;
			lab_ErrorMsg.verticalCenter = 60;
		}
		
		public var obj_ViewManager:*;
		public var grp_ViewStage:Group = new Group();

		public var grp_ErrorStage:Group = new Group();
		public var lab_ErrorCode:Label = new Label();
		public var lab_ErrorMsg:Label = new Label();
		
		public var now_View:IVisualElement;
		
		public function change_View(evt:Oev_ChangeView):void
		{
			grp_ViewStage.removeAllElements();
			now_View = new Group();
			
			var change_Class:Class = obj_ViewManager[evt.catch_CallLabel];
			now_View = new change_Class();
			
			grp_ViewStage.addElement(now_View);
		}
		
		public function error_View(evt:Oev_ErrorView):void
		{
			
		}
		
		public function error_Stage(trg_ErrorCode:String,trg_ErrorMsg:String):void
		{
			grp_ErrorStage.graphics.clear();
			grp_ErrorStage.graphics.beginFill(0x000000,0.8);
			grp_ErrorStage.graphics.drawRect(0,0,grp_ViewStage.width,grp_ViewStage.height);
			
			grp_ErrorStage.addElement(lab_ErrorCode);
			grp_ErrorStage.addElement(lab_ErrorMsg);

			lab_ErrorCode.text = trg_ErrorCode;
			lab_ErrorMsg.text = trg_ErrorMsg;
			
			grp_ErrorStage.visible = true;
		}
		
	}
}