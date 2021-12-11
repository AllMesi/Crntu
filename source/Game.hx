import flixel.FlxGame;
// import openfl.display.Sprite;
import flixel.FlxG;
import lime.app.Application;
import openfl.events.Event;
import openfl.Lib;
import flixel.system.scaleModes.StageSizeScaleMode;
import openfl.display.FPS;
import misc.LoadState;
import children.Info;
import openfl.events.Event;
import openfl.events.UncaughtErrorEvent;

// import systools.Dialogs;
class Game extends openfl.display.Sprite
{
	public static var gw = 1280;
	public static var gh = 720;
	// var gw = Lib.current.stage.stageWidth;
	// var gh = Lib.current.stage.stageHeight;
	public static var ist = Square;
	public static var zoom = 1;
	public static var f = 120;
	public static var ss = true;
	public static var sfs = false;

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
		// Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		// Dialogs.message("WARNING", "this \"game\" sucks and still has a 0 at the start of the version", false);
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
		addChild(new Info(0, 0, 0xFFFFFF));
		toggleFPS(FlxG.save.data.info);
		// FlxG.scaleMode = new StageSizeScaleMode();
		// FlxG.debugger.toggleKeys = [F3];
	}

	public function toggleFPS(infoEnabled:Bool):Void
	{
		addChild(new Info(10, 3, 0xFFFFFF)).visible = infoEnabled;
	}
}
