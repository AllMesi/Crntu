import lime.app.Application;
import openfl.Lib;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxSubState;
import flixel.FlxSprite;

class LoadStateLeave extends FlxState
{
	var one:FlxText;

	override public function create()
	{
		super.create();

		Square.unloadmouse(false);
        FlxG.updateFramerate = 120;
        FlxG.drawFramerate = 120;
		one = new FlxText(0, 0, 0, "Are You Sure? If you leave now ALL mouse input will stop working. (Y, N)", 42);
		one.setFormat('_sans', 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		one.screenCenter();
		add(one);
        FlxG.fullscreen = true;
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
        if (FlxG.keys.justPressed.N)
        {
            FlxG.fullscreen = false;
            FlxG.switchState(new LoadState());
        }

        if (FlxG.keys.justPressed.Y)
        {
            FlxG.fullscreen = false;
            FlxG.switchState(new Start());
        }
	}
}