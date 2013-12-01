package Controllers.Components
{
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.controls.CheckBox;
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	
	import Views.Components.Ocv_TilingCheckBox;
	
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
			
			//update(test_Rows,test_Cols);
		}
		
		private var flg_NewMode:Boolean = false;
		
		private static var AllSelect:String = "AllSelect";
		private static var flg_AllSelect:Boolean = true;
		private static var Btn_Rows:String = "btn_Rows_";
		private static var Btn_Cols:String = "btn_Cols_";
		
		private var ary_Rows_ControllData:Array = new Array();
		private var ary_Cols_ControllData:Array = new Array();

		private var cnt_Rows:uint = 0;
		private var cnt_Cols:uint = 0;
		
		private var ary_CheckBox:Array = new Array();		
		private var ary_Rows_BtnElements:Array = new Array();
		private var ary_Cols_BtnElements:Array = new Array();

		private var common_Width:Number = new Number();
		private var common_Height:Number = 30;
		
		public function update(trg_Rows_Array:Array,trg_Cols_Array:Array,trg_NewMode:Boolean = false):void
		{
			flg_NewMode = trg_NewMode;
			
			ary_Rows_ControllData = trg_Rows_Array;
			ary_Cols_ControllData = trg_Cols_Array;
			
			cnt_Rows = ary_Rows_ControllData.length;
			cnt_Cols = ary_Cols_ControllData.length;
			
			ary_CheckBox = new Array();
			
			common_Width = view.width / (ary_Rows_ControllData.length + 1);
			common_Width -= view.horizontalGap;
			
			remove_BtnFunction();
			
			view.removeAllElements();
			
			create_firstRow();
		}

		private var btn_AllSelect:Button = new Button();

		private function create_firstRow():void
		{
			btn_AllSelect.label = AllSelect;
			btn_AllSelect.id = "btn_" + AllSelect;
			btn_AllSelect.width = common_Width;
			btn_AllSelect.height = common_Height;
			btn_AllSelect.addEventListener(MouseEvent.CLICK , click_Btn_AllSelect);
			view.addElement(btn_AllSelect);
			
			if(ary_Cols_ControllData.length > 0)
			{
				for each (var trg_Data:String in ary_Rows_ControllData)
				{
					var add_btn:Button = new Button();
					
					add_btn.label = trg_Data;
					add_btn.name = ary_Rows_BtnElements.length.toString();
					add_btn.id = Btn_Rows + trg_Data;
					add_btn.width = common_Width;
					add_btn.height = common_Height;
					add_btn.addEventListener(MouseEvent.CLICK , click_Btn_RowsSelect);
					
					ary_Rows_BtnElements.push(add_btn);
					view.addElement(add_btn);
				}
				
				create_NextRows();
			} else {
				create_CheckBox();
			}
		}
		
		private function create_NextRows():void
		{
			
			for each (var trg_ColsData:String in ary_Cols_ControllData)
			{
				var add_btn:Button = new Button();
				
				add_btn.label = trg_ColsData;
				add_btn.name = ary_Cols_BtnElements.length.toString();
				add_btn.id = Btn_Cols + trg_ColsData;
				add_btn.width = common_Width;
				add_btn.height = common_Height;
				add_btn.addEventListener(MouseEvent.CLICK , click_Btn_ColsSelect);
				
				ary_Cols_BtnElements.push(add_btn);
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
				//add_cb.label = ary_CheckBox.length.toString();
				add_cb.id = "ckb_" + trg_RowsData;
				add_cb.width = common_Width;
				add_cb.height = common_Height;
				add_cb.selected = flg_NewMode;
				
				ary_CheckBox.push(add_cb);
				view.addElement(add_cb);
			}
		}
		
		private function click_Btn_AllSelect(evt:MouseEvent):void
		{
			for each(var trg_CheckBox:CheckBox in ary_CheckBox)
			{
				trg_CheckBox.selected = flg_AllSelect;
			}
			
			if(flg_AllSelect)
			{
				flg_AllSelect = false;
			} else {
				flg_AllSelect = true;
			}
		}

		private function click_Btn_RowsSelect(evt:MouseEvent):void
		{
			var start_Cnt:uint = Number(evt.currentTarget.name);
			
			for(var i:uint = 0 ; i < cnt_Cols ; i++)
			{
				var trg_Index:uint = (cnt_Rows * i) + start_Cnt;
				var trg_CheckBox:CheckBox = ary_CheckBox[trg_Index];
				
				trg_CheckBox.selected = true;
			}
		}

		private function click_Btn_ColsSelect(evt:MouseEvent):void
		{
			var start_Cnt:uint = Number(evt.currentTarget.name);
			
			for(var i:uint = 0 ; i < cnt_Rows ; i++)
			{
				var trg_Index:uint = (cnt_Rows * start_Cnt) + i;
				var trg_CheckBox:CheckBox = ary_CheckBox[trg_Index];
				
				trg_CheckBox.selected = true;
			}
		}
		
		override public function remove_BtnFunction():void
		{
			if(view.numElements > 0)
			{
				
				btn_AllSelect.removeEventListener(MouseEvent.CLICK , click_Btn_AllSelect);
				
				for each(var rows_Btn:Button in ary_Rows_BtnElements)
				{
					rows_Btn.removeEventListener(MouseEvent.CLICK , click_Btn_RowsSelect);
				}
				
				for each(var cols_Btn:Button in ary_Cols_BtnElements)
				{
					cols_Btn.removeEventListener(MouseEvent.CLICK , click_Btn_ColsSelect);
				}
			}
			
			ary_Rows_BtnElements = new Array();
			ary_Cols_BtnElements = new Array();
		}
		
		public function throw_CheckValue():Array
		{
			var ret_Array:Array = new Array();
			
			for each(var trg_CheckBox:CheckBox in ary_CheckBox)
			{
				ret_Array.push(trg_CheckBox.selected);
			}
			
			return ret_Array;
		}
		
		override public function exit_View():void
		{
			remove_BtnFunction();
		}
	}
}