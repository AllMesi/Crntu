import flixel.FlxGame;
import openfl.display.Sprite;
import flixel.FlxG;
import lime.app.Application;
import openfl.events.Event;
import openfl.Lib;

class Game extends Sprite
{
	var gw = 1280;
	var gh = 720;
	var ist = LoadState;
	var zoom = 1;
	var f = 120;
	var ss = true;
	var sfs = false;

	// You can pretty much ignore everything from here on - your code should go in your states.

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
		Square.log('Setup from main');
		addChild(new FlxGame(gw, gh, ist, zoom, f, f, ss, sfs));
		addChild(new Info(10, 3, 0xFFFFFF));
		toggleFPS(FlxG.save.data.info);
	}

	public function toggleFPS(infoEnabled:Bool):Void
	{
		addChild(new Info(10, 3, 0xFFFFFF)).visible = infoEnabled;
	}
}
