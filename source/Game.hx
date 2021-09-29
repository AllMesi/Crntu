package;

import square.Square;
import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;
import square.Info;
import square.Fullscreen;
import Options;
import lime.app.Application;

class Game extends Sprite
{
	var gw = 1280;
	var gh = 720;
	var ist = ApplyOptions;
	var zoom = 1;
	var f = 120;
	var ss = true;
	var sfs = false;
	public function new()
	{
		super();
		addChild(new FlxGame(gw, gh, ist, zoom, f, f, ss, sfs));
		addChild(new Info(10, 3, 0xffffff));
		trace("Main File");
	}
}
