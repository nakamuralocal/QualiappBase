package Singletons
{
	import flash.errors.IOError;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	
	import mx.utils.ObjectUtil;
	
	public class Sig_JSON_Master extends EventDispatcher
	{
		private var M_APP:Sig_APP_Master = Sig_APP_Master.getInstance();
		
		private var File_JSON:File;
		private var FS_JSON:FileStream;
		private var FFilter_JSON:FileFilter = new FileFilter("JSONファイル",".json");
		private var dir_JSON:String = new String();
		private var fName_JSON:String = new String();
		
		private var ret_Object:Object;
		private var cla_Model:Class;
		private var str_load_JSON:String = new String();
		private var complete_load_Function:Function;
		
		private var flg_SingleMode:Boolean = new Boolean();
		
		public function save_JSON(trg_Object:Object,trg_SaveDir:String,trg_SaveFileName:String):void
		{
			var str_SaveString:String = JSON.stringify(trg_Object);
			
			File_JSON = new File(trg_SaveDir + M_APP.FS + trg_SaveFileName + ".json");
			FS_JSON = new FileStream();
			FS_JSON.open(File_JSON,FileMode.WRITE);
			
			try
			{
				FS_JSON.writeUTFBytes(str_SaveString);
			} finally {
				trace("Save Complete : " + File_JSON.nativePath);
				FS_JSON.close();
			}
		}
		
		public function load_JSON(
			trg_SingleMode:Boolean,
			trg_Object:*,
			trg_Class:Class,
			trg_CallFunction:Function,
			trg_LoadDir:String,
			trg_LoadFileName:String):void
		{
			flg_SingleMode = trg_SingleMode;
			ret_Object = trg_Object;
			cla_Model = trg_Class;
			complete_load_Function = trg_CallFunction;
			str_load_JSON = new String();
			
			File_JSON = new File(trg_LoadDir + M_APP.FS + trg_LoadFileName + ".json");
			FS_JSON = new FileStream();
			
			var flg_Succes:Boolean = true;
			
			try
			{
				FS_JSON.open(File_JSON,FileMode.READ);
				FS_JSON.position = 0;
				str_load_JSON = FS_JSON.readUTFBytes(File_JSON.size);
			} catch (err:IOError) {
				flg_Succes = false;
			} finally {
				FS_JSON.close();
				
				if(flg_Succes)
				{
					complete_load_JSON();
				} else {
					error_load_JSON();
				}
			}
		}
		
		public function error_load_JSON():void
		{
			M_APP.error_View(M_APP.ERR_Load,File_JSON.nativePath);
		}
		
		public function complete_load_JSON():void
		{
			if(flg_SingleMode)
			{
				parse_Single();
			} else {
				parse_Array();
			}
		}
		
		private function parse_Single():void
		{
			ret_Object = JSON.parse(str_load_JSON);
			
			complete_load_Function(ret_Object);
		}
		
		private function parse_Array():void
		{
			var load_Object:Object = JSON.parse(str_load_JSON);
			var ary_MainKey:Array = new Array();
			
			for (var MainKey:String in load_Object)
			{
				ary_MainKey.push(MainKey);
			}
			
			for (var i:uint = 0 ; i < ary_MainKey.length ; i++)
			{
				var push_Key:String = ary_MainKey[i];
				var read_Object:Object = load_Object[push_Key];
				var push_Object:Object = new cla_Model();
				
				for (var key:String in read_Object)
				{
					var pass_String:String = read_Object[key];
					
					if(pass_String.indexOf("GMT") >= 0)
					{
						var date_MillSec:Number = Date.parse(pass_String);
						var passDate:Date = new Date(date_MillSec);
						
						push_Object[key] = passDate;
					} else {
						push_Object[key] = read_Object[key];
					}

				}
				
				ret_Object[push_Key] = push_Object;
			}
			complete_load_Function();
		}
		
		private static var _instance:Sig_JSON_Master;
		
		public function Sig_JSON_Master(privateClass:PrivateClass,target:IEventDispatcher=null)
		{
			super(target);
		}

		public static function getInstance():Sig_JSON_Master {
			if (!_instance) {
				_instance = new Sig_JSON_Master(new PrivateClass,null);
			}
			return _instance;
		}
	}
}

class PrivateClass {
}