package Controllers.Components
{
	import Views.Components.Ocv_TilingCheckBox;
	
	import flash.events.IEventDispatcher;
	
	import mx.controls.Button;
	import mx.controls.CheckBox;
	import mx.controls.Spacer;
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	
	public class Occ_TilingCheckBox extends Occ_00_MasterComponents implements IMXMLObject
	{
		public function Occ_TilingCheckBox(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function initialized(document:Object, id:String):void
		{
			view = document as Ocv_TilingCheckBox;
			view.addEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
		}
		
		private var view:Ocv_TilingCheckBox;
		
		private function complete_CreationView(evt:FlexEvent):void
		{
			view.removeEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
			
			var test_Rows:Array = ["G","D","E","V","Hybrid"]
			var test_Cols:Array = ["7","8"];
			
			init(test_Rows,test_Cols);
		}
		
		private var ary_BaseData:Array = new Array();
		private var ary_Rows_ControllData:Array = new Array();
		private var ary_Cols_ControllData:Array = new Array();
		
		private var common_Width:Number = new Number();
		private var common_Height:Number = 30;
		
		public function init(trg_Rows_Array:Array,trg_Cols_Array:Array):void
		{
			ary_Rows_ControllData = trg_Rows_Array;
			ary_Cols_ControllData = trg_Cols_Array;
			
			common_Width = view.width / (ary_Rows_ControllData.length + 1);
			common_Width -= view.horizontalGap;
			
			create_firstRow();
		}
		
		private function create_firstRow():void
		{
			view.removeAllElements();
			
			var btn_AllSelect:Button = new Button();
			
			btn_AllSelect.label = "AllSelect";
			btn_AllSelect.id = "btn_AllSelect";
			btn_AllSelect.width = common_Width;
			btn_AllSelect.height = common_Height;
			
			view.addElement(btn_AllSelect);
			
			if(ary_Cols_ControllData.length == 0)
			{
				create_CheckBox();
			} else {
			
				for each (var trg_Data:String in ary_Rows_ControllData)
				{
					var add_btn:Button = new Button();
					
					add_btn.label = trg_Data;
					add_btn.id = "btn_" + trg_Data;
					add_btn.width = common_Width;
					add_btn.height = common_Height;
					
					view.addElement(add_btn);
				}
				
				create_NextRows();
			}
		}
		
		private function create_NextRows():void
		{
			for each (var trg_ColsData:String in ary_Cols_ControllData)
			{
				var add_btn:Button = new Button();
				
				add_btn.label = trg_ColsData;
				add_btn.id = "btn_" + trg_ColsData;
				add_btn.width = common_Width;
				add_btn.height = common_Height;
				
				view.addElement(add_btn);
				
				create_CheckBox();
			}
		}
		
		private function create_CheckBox():void
		{
			
			for each (var trg_RowsData:String in ary_Rows_ControllData)
			{
				var add_cb:CheckBox = new CheckBox();
				
				add_cb.label = trg_RowsData;
				add_cb.id = "ckb_" + trg_RowsData;
				add_cb.width = common_Width;
				add_cb.height = common_Height;
				
				view.addElement(add_cb);
			}
		}
	}
}