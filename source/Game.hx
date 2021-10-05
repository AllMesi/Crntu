// package;

import flixel.FlxGame;
import openfl.display.Sprite;
import square.InfoAndConfig;
import flixel.FlxG;
import lime.app.Application;
import openfl.events.Event;
import openfl.Lib;

// class Game extends Sprite
// {
// 	public function new()
// 	{
		// var gw = Application.current.window.display.currentMode.width;
		// var gh = Application.current.window.display.currentMode.height;
		// var ist = LoadState;
		// var zoom = 1;
		// var f = 120;
		// var ss = true;
		// var sfs = false;
// 		super();
		// addChild(new FlxGame(gw, gh, ist, zoom, f, f, ss, sfs));
		// addChild(new InfoAndConfig(10, 3, 0xffffff));
// 	}
// }

class Game extends Sprite
{
	var gw = Application.current.window.display.currentMode.width;
	var gh = Application.current.window.display.currentMode.height;
	var ist = LoadState;
	var zoom = 1;
	var f = 120;
	var ss = true;
	var sfs = false;

	public static function game():Void
	{
		Lib.current.addChild(new Game());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		// addChild(new FlxGame(gw, gh, ist, zoom, f, f, ss, sfs));
		// addChild(new InfoAndConfig(10, 3, 0xffffff));
	}

	private function init(?E:Event):Void
		{
			if (hasEventListener(Event.ADDED_TO_STAGE))
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
	
			setupGame();
		}

		private function setupGame():Void
		{
			var sw:Int = Lib.current.stage.stageWidth;
			var sh:Int = Lib.current.stage.stageHeight;

			// if (zoom == -1)
			// {
			// 	var ratioX:Float = sw / gw;
			// 	var ratioY:Float = sh / gh;
			// 	zoom = Math.min(ratioX, ratioY);
			// 	gameWidth = Math.ceil(sh / zoom);
			// 	gameHeight = Math.ceil(sh / zoom);
			// }
			Debug.onInitProgram();
			addChild(new FlxGame(gw, gh, ist, zoom, f, f, ss, sfs));
			info = new InfoAndConfig(10, 3, 0xFFFFFF);
			addChild(info);
			toggleFPS(FlxG.save.data.info);
		}

		var info:InfoAndConfig;

		public function toggleFPS(infoEnabled:Bool):Void
		{
			info.visible = infoEnabled;
		}

}
