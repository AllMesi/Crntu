import flixel.util.FlxTimer;
import flixel.FlxGame;
import flixel.FlxG;
import openfl.display.Sprite;
import lime.app.Application;
import openfl.events.Event;
import openfl.Lib;
import flixel.system.scaleModes.StageSizeScaleMode;
import openfl.display.FPS;
import children.Info;
import flixel.util.FlxColor;
import flixel.system.scaleModes.FixedScaleMode;

/**
 * Makes the main window and powers the whole game
 */
class Game extends Sprite
{
	public static var gw = 1560;
	public static var gh = 720;
	// var gw = Lib.current.stage.stageWidth;
	// var gh = Lib.current.stage.stageHeight;
	public static var ist = misc.LoadState;
	public static var zoom = 1;
	public static var f = 120;
	public static var ss = true;
	public static var sfs = true;

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
		// Application.current.window.alert("This game is VERY unoptimized and a memory hog its stupid aaaaaa", "<WARNING>");
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
		Crntu.log('Setup from main');
		// Debug.onInitProgram();
		FlxG.fullscreen = false;
		addChild(new FlxGame(gw, gh, ist, zoom, f, f, ss, sfs));
		addChild(new Info(0, 0, 0xFFFFFF));
		toggleFPS(FlxG.save.data.info);
		FlxG.sound.muteKeys = [];
		FlxG.sound.volumeDownKeys = [];
		FlxG.sound.volumeUpKeys = [];
		// var a:FillScaleMode = new FillScaleMode();
		// FlxG.scaleMode = a;
		FlxG.scaleMode = new StageSizeScaleMode();
		FlxG.autoPause = false;
		setExitHandler(function()
		{
			// Crntu.log('exited', false, 'CrntuBackground', false);
      Crntu.logInfo('Game Closed');
			Sys.exit(0);
		});
		FlxG.fixedTimestep = false;
		// Debug.onGameStart();
	}

  static function setExitHandler(func:Void->Void):Void
	{
		openfl.Lib.current.stage.application.onExit.add(function(code)
		{
			openfl.Lib.current.stage.application.onExit.cancel();
			func();
		});
	}

	public function toggleFPS(infoEnabled:Bool):Void
	{
		addChild(new Info(10, 3, 0xFFFFFF)).visible = infoEnabled;
	}
}
