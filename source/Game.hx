package;

import flixel.FlxGame;
import openfl.display.Sprite;
import square.InfoAndConfig;
import flixel.FlxG;

class Game extends Sprite
{
	var gw = 2560;
	var gh = 1080;
	var ist = LoadState;
	var zoom = 1;
	var f = 120;
	var ss = true;
	var sfs = false;
	public function new()
	{
		super();
		addChild(new FlxGame(gw, gh, ist, zoom, f, f, ss, sfs));
		addChild(new InfoAndConfig(10, 3, 0xffffff));
	}
}
