package Controllers.Components
{
	import Events.Oev_FreeAddItem;
	
	import Views.Components.Ocv_FreeAddTextItem;
	
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	
	public class Occ_FreeAddTextItem extends Occ_00_MasterComponents implements IMXMLObject
	{
		public function Occ_FreeAddTextItem(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function initialized(document:Object, id:String):void
		{
			view = document as Ocv_FreeAddTextItem;
			view.addEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
		}
		
		private var view:Ocv_FreeAddTextItem;
		
		private function complete_CreationView(evt:FlexEvent):void
		{
			view.removeEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
		}
		
		public var my_Index:uint;
		
		public function init(trg_Index:uint):void
		{
			my_Index = trg_Index;
			
			view.lab_Index.text = String(my_Index + 1);
			
			add_BtnFuction();
		}
		
		public function return_Text():String
		{
			var ret_String:String = new String();
			
			switch(view.txi_ItemText.text)
			{
				case "":
				case " ":
				case "　":
					ret_String = null;
					break;
				
				default:
					ret_String = view.txi_ItemText.text;
					break;
			}
			
			return ret_String;
		}
		
		private function throw_ChangeData(evt:FocusEvent):void
		{
			dispatchEvent(new Oev_FreeAddItem(Oev_FreeAddItem.CHANGE_TEXT_DATA , my_Index));
		}
		
		private function click_btn_addNext(evt:MouseEvent):void
		{
			dispatchEvent(new Oev_FreeAddItem(Oev_FreeAddItem.REG_ITEM,my_Index));
		}
		
		private function click_btn_deleteThis(evt:MouseEvent):void
		{
			if(my_Index == 0)
			{
				view.txi_ItemText.text = "";	
			} else {
				dispatchEvent(new Oev_FreeAddItem(Oev_FreeAddItem.UNREG_ITEM,my_Index));
			}
		}
		
		public override function add_BtnFuction():void
		{
			view.txi_ItemText.addEventListener(FocusEvent.FOCUS_OUT,throw_ChangeData);
			view.btn_addNext.addEventListener(MouseEvent.CLICK , click_btn_addNext);
			view.btn_deleteThis.addEventListener(MouseEvent.CLICK , click_btn_deleteThis);
		}

		public override function remove_BtnFuction():void
		{
			view.txi_ItemText.removeEventListener(FocusEvent.FOCUS_OUT,throw_ChangeData);
			view.btn_addNext.removeEventListener(MouseEvent.CLICK , click_btn_addNext);
			view.btn_deleteThis.removeEventListener(MouseEvent.CLICK , click_btn_deleteThis);
		}
	}
}