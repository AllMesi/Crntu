import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxState;

class GameOver extends FlxState
{
    var backdrop = new FlxBackdrop(Paths.image('sb'));
    var one:FlxText;
    override public function create()
    {
        FlxG.camera.fade(FlxColor.BLACK, 0.77, true);
        backdrop.cameras = [FlxG.camera];
		backdrop.velocity.set(0, 150);
		add(backdrop);
        one = new FlxText(0, 0, 0, "You Lost, press enter to continue", 42);
		one.setFormat('_sans', 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		one.screenCenter();
		add(one);
        FlxG.sound.playMusic(Paths.music('MenuMusic'), 0);
        FlxG.sound.music.fadeIn(4, 0, 0.7);
        super.create();
    }

    override public function update(elapsed:Float)
    {
        if (FlxG.keys.justPressed.ENTER)
        {
            FlxG.switchState(new Menu());
        }
        super.update(elapsed);
    }
}