package;

import flixel.FlxGame;
import openfl.display.Sprite;
import square.InfoAndConfig;
import flixel.FlxG;
import lime.app.Application;

class Game extends Sprite
{
	public function new()
	{
		var gw = Application.current.window.display.currentMode.width;
		var gh = Application.current.window.display.currentMode.height;
		var ist = LoadState;
		var zoom = 1;
		var f = 120;
		var ss = true;
		var sfs = false;
		super();
		addChild(new FlxGame(gw, gh, ist, zoom, f, f, ss, sfs));
		addChild(new InfoAndConfig(10, 3, 0xffffff));
	}
}
