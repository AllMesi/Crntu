package misc;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;

class OutdatedAlert extends FlxState
{
	public static var leftState:Bool = false;

	var backdrop = new FlxBackdrop(Paths.image('sb'));
	var http = new haxe.Http("https://raw.githubusercontent.com/AllMesi/Square/main/version");
	var ver = Square.VER;

	public static var needVer:String = "a";
	public static var currChanges:String = "a";

	override public function create()
	{
		super.create();
		backdrop.cameras = [FlxG.camera];
		backdrop.velocity.set(0, 150);
		add(backdrop);

		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"HEY! You're running an outdated version of the game!\nCurrent version is "
			+ ver
			+ " while the most recent version is "
			+ needVer
			+ "! Press Space to go to the github, or ESCAPE to ignore this!!",
			32);
		txt.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		txt.screenCenter();
		add(txt);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.SPACE)
		{
			Square.openURL("https://github.com/AllMesi/Square");
		}
		if (FlxG.keys.justPressed.ESCAPE)
		{
			leftState = true;
			FlxG.switchState(new SplashScreens());
		}
		super.update(elapsed);
	}
}
