package Controllers.Components
{
	import Events.Oev_FreeAddGroup;
	import Events.Oev_FreeAddItem;
	
	import Views.Components.Ocv_FreeAddTextGroup;
	import Views.Components.Ocv_FreeAddTextItem;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.controls.Spacer;
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	
	public class Occ_FreeAddTextGroup extends Occ_00_MasterComponents implements IMXMLObject
	{
		public static const MODE_TEXT:String = "mode_text";
		public static const MODE_FILE_PATH:String = "mode_file_path";
		
		public function Occ_FreeAddTextGroup(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function initialized(document:Object, id:String):void
		{
			view = document as Ocv_FreeAddTextGroup;
			view.addEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
		}
		
		private var view:Ocv_FreeAddTextGroup;
		
		private function complete_CreationView(evt:FlexEvent):void
		{
			view.removeEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
			init();
		}
		
		private var ary_Items:Array = new Array()
		
		public function init(trg_Ary:Array = null):void
		{
			if(trg_Ary == null)
			{
				reg_Items(-1);
			} else {
				for (var i:uint = 0 ; i < trg_Ary.length ; i++)
				{
					reg_Items(i-1,trg_Ary[i]);
				}
			}
		}
		
		public function change_Data(evt:Oev_FreeAddItem = null):void
		{
			var trg_Array:Array = throw_Item();
			
			dispatchEvent(new Oev_FreeAddGroup(Oev_FreeAddGroup.CHANGE_DATA , trg_Array));
		}
		
		public function throw_Item():Array
		{
			var ret_Array:Array = new Array();
			
			for each(var trg_Item:Ocv_FreeAddTextItem in ary_Items)
			{
				if(trg_Item.viewCon.return_Text() != null)
				{
					ret_Array.push(trg_Item.viewCon.return_Text());
				}
			}
			
			return ret_Array;
		}
			
		private function reg_Items(trg_IndexNum:int, trg_Text:String = ""):void
		{
			remove_Items();
			
			var reg_Item:Ocv_FreeAddTextItem = new Ocv_FreeAddTextItem();
			reg_Item.txi_ItemText.text = trg_Text;
			
			if(trg_IndexNum == ary_Items.length - 1)
			{
				ary_Items.push(reg_Item);
			} else {
				var cnt_Splice:uint = (ary_Items.length - trg_IndexNum) - 1;
				var concat_ary:Array = ary_Items.splice(trg_IndexNum + 1 , cnt_Splice);
				ary_Items.push(reg_Item);
				
				ary_Items = ary_Items.concat(concat_ary);
			}
			
			add_Items();
		}
		
		private function unReg_Item(trg_IndexNum:uint):void
		{
			remove_Items();
			
			ary_Items.splice(trg_IndexNum,1);
			
			add_Items();
		}
		
		private function add_Items():void
		{
			var cnt_Loop:uint = 0;
			
			for each(var trg_Item:Ocv_FreeAddTextItem in ary_Items)
			{
				trg_Item.viewCon.init(cnt_Loop);
				trg_Item.viewCon.addEventListener(Oev_FreeAddItem.REG_ITEM , catch_Reg_Items);
				trg_Item.viewCon.addEventListener(Oev_FreeAddItem.UNREG_ITEM , catch_UnReg_Items);
				trg_Item.viewCon.addEventListener(Oev_FreeAddItem.CHANGE_TEXT_DATA , change_Data);
				view.vgr_addSpace.addElementAt(trg_Item,trg_Item.viewCon.my_Index);
				
				++cnt_Loop;
			}
			
			view.vgr_addSpace.verticalScrollPosition = view.vgr_addSpace.contentHeight;
			
			change_Data();
		}
		
		private function remove_Items():void
		{
			var spacer_Hight:uint = new uint();
			
			for each(var trg_Item:Ocv_FreeAddTextItem in ary_Items)
			{
				trg_Item.viewCon.removeEventListener(Oev_FreeAddItem.REG_ITEM , catch_Reg_Items);
				trg_Item.viewCon.removeEventListener(Oev_FreeAddItem.UNREG_ITEM , catch_UnReg_Items);
				trg_Item.viewCon.removeEventListener(Oev_FreeAddItem.CHANGE_TEXT_DATA , change_Data);
				trg_Item.viewCon.exit_View();
				spacer_Hight = trg_Item.height;
			}
			
			view.vgr_addSpace.removeAllElements();
			
			var temp_Spacer:Spacer = new Spacer();
			temp_Spacer.height = spacer_Hight;
			view.vgr_addSpace.addElement(temp_Spacer);
		}
		
		private function catch_Reg_Items(evt:Oev_FreeAddItem):void
		{
			reg_Items(evt.catch_IndexNum);
		}
		
		private function catch_UnReg_Items(evt:Oev_FreeAddItem):void
		{
			unReg_Item(evt.catch_IndexNum);
		}
		
		public override function exit_View():void
		{	
			remove_Items();
		}
	}
}