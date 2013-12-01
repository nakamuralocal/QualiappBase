package Singletons
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.system.Capabilities;
	
	import Events.Oev_ChangeView;
	import Events.Oev_ErrorView;
	
	public class Sig_APP_Master extends EventDispatcher
	{
		public const ERR_Load:String = "err_001_001";
		
		public function change_View(trg_CallLabel:String):void
		{
			dispatchEvent(new Oev_ChangeView(Oev_ChangeView.CHANGE_VIEW , trg_CallLabel));
		}
		
		public function error_View(trg_ErrorCode:String,trg_ErrorMsg:String):void
		{
			dispatchEvent(new Oev_ErrorView(Oev_ErrorView.ERROR_VIEW,trg_ErrorCode,trg_ErrorMsg));
		}
		
		public function get FS():String
		{
			var ret_String:String = Capabilities.os;
			
			if(ret_String.match("Windows"))
			{
				ret_String = "¥¥";
			} else if(ret_String.match("Mac")){
				ret_String = "/";
			}
			
			return ret_String;
		}
		
		public function hardWrap(trg_Number:Number,trg_Digit:Number = 2):String
		{
			var ret_String:String = trg_Number.toString();
			var cnt_AddZero:Number = trg_Digit - ret_String.length;
			
			for (var i:uint = 0 ; i < cnt_AddZero ; i++)
			{
				ret_String = "0" + ret_String;
			}
			
			return ret_String;
		}
		
		public static const FullDate:String = "FullDate";
		public static const DateOnly:String = "DateOnly";
		public static const TimeOnly:String = "TimeOnly";
		
		public function convert_DateToString(trg_Date:Date,trg_RetMode:String = FullDate):String
		{
			var ret_String:String = new String();
			var ary_Day:Array = ["日","月","火","水","木","金","土"];
			
			var temp_Year:Number = trg_Date.getFullYear();
			var temp_Month:Number = (trg_Date.getMonth() + 1);
			var temp_Date:Number = trg_Date.getDate();
			var temp_Day:String = ary_Day[trg_Date.getDay()];
			
			var temp_Hours:Number = trg_Date.getHours();
			var temp_Minutes:Number = trg_Date.getMinutes();
			var temp_Secconds:Number = trg_Date.getSeconds();
			
			switch(trg_RetMode)
			{
				case FullDate:
					ret_String =
						hardWrap(temp_Year,4) + "年" +
						hardWrap(temp_Month) + "月" +
						hardWrap(temp_Date) + "日" +
						" (" + temp_Day + ") " +
						hardWrap(temp_Hours) + ":" +
						hardWrap(temp_Minutes) + ":" +
						hardWrap(temp_Secconds);
						break;
				
				case DateOnly:
					ret_String =
					hardWrap(temp_Year,4) + "年" +
					hardWrap(temp_Month) + "月" +
					hardWrap(temp_Date) + "日" +
					" (" + temp_Day + ")";
					break;
				
				case TimeOnly:
					ret_String =
					hardWrap(temp_Hours) + ":" +
					hardWrap(temp_Minutes) + ":" +
					hardWrap(temp_Secconds);
					break;
			}
			
			return ret_String;
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