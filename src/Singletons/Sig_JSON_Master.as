package Singletons
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	
	import mx.utils.ObjectUtil;
	
	public class Sig_JSON_Master extends EventDispatcher
	{
		private var File_JSON:File;
		private var FS_JSON:FileStream;
		private var FFilter_JSON:FileFilter = new FileFilter("JSONファイル",".json");
		private var dir_JSON:String = new String();
		private var fName_JSON:String = new String();
		
		private var ret_Array:Array;
		private var cla_Model:Class;
		private var str_load_JSON:String = new String();
		private var complete_load_Function:Function;
		
		public function save_JSON(trg_Object:Object,trg_SaveDir:String,trg_SaveFileName:String):void
		{
			var str_SaveString:String = JSON.stringify(trg_Object);
			
			File_JSON = new File(trg_SaveDir + "/" + trg_SaveFileName + ".josn");
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
		
		public function load_JSON(trg_Array:Array,trg_Class:Class,trg_CallFunction:Function,trg_LoadDir:String,trg_LoadFileName:String):void
		{
			ret_Array = trg_Array;
			cla_Model = trg_Class;
			complete_load_Function = trg_CallFunction;
			str_load_JSON = new String();
			
			File_JSON = new File(trg_LoadDir + "/" + trg_LoadFileName + ".josn");
			FS_JSON = new FileStream();
			FS_JSON.open(File_JSON,FileMode.READ);
			FS_JSON.position = 0;
			
			try
			{
				str_load_JSON = FS_JSON.readUTFBytes(File_JSON.size);
			} finally {
				complete_load_JSON();
			}
		}
		
		public function complete_load_JSON():void
		{
			var load_Object:Object = JSON.parse(str_load_JSON);
			
			for each(var read_Object:Object in load_Object)
			{
				var push_Object:Object = new cla_Model();
				
				for (var key:String in read_Object)
				{
					var pass_String:String = read_Object[key];
					
					if(pass_String.indexOf("GMT") >= 0)
					{
						var dateMilSec:Number = Date.parse(pass_String);
						var passDate:Date = new Date(dateMilSec);
						
						push_Object[key] = passDate;
					} else {
						push_Object[key] = read_Object[key];
					}
					
				}
				ret_Array.push(push_Object);
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