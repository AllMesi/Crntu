import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;

class OutdatedAlert extends FlxState
{
    var backdrop = new FlxBackdrop(Paths.image('sb'));
    override public function create()
    {
        super.create();
        backdrop.cameras = [FlxG.camera];
		backdrop.velocity.set(0, 150);
		add(backdrop);
    }
}