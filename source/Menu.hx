package;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxState;
import square.FlxBackdrop;

class Menu extends FlxState
{
    var title:FlxText;
    var play:FlxButton;
    var back:FlxButton;
    var options:FlxButton;
    var reset:FlxButton;

    override function create() 
    {
        var backdrop = new FlxBackdrop(Paths.image('sb'));
        backdrop.cameras = [FlxG.camera];
		backdrop.velocity.set(0, 150);
		add(backdrop);
        title = new FlxText(50, 100, 0, "Square", 18);
        title.setFormat("_sans", 16, FlxColor.WHITE, CENTER);
        title.screenCenter(X);
        add(title);

        // play = new FlxButton((FlxG.width / 2) - (play.width / 2), (FlxG.height / 2), "Play", p);
        play = new FlxButton(0, 0, "Play", p);
        play.x = (FlxG.width / 2) - (play.width / 2);
		play.y = (FlxG.height / 2);
        play.loadGraphic(Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
        add(play);

        // back = new FlxButton(((FlxG.width / 2) - back.width / 2), (FlxG.height / 2) + play.height + 10, "back", b);\
        options = new FlxButton(0, 30, "Options", o);
        options.x = ((FlxG.width / 2) - options.width / 2);
		options.y = (FlxG.height / 2) + play.height + 3;
        options.loadGraphic(Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
        add(options);

        reset = new FlxButton(100, 0, "reset", r);
        reset.loadGraphic(Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
        add(reset);

        back = new FlxButton(0, 30, "Back", b);
        back.x = ((FlxG.width / 2) - back.width / 2);
		back.y = (FlxG.height / 2) + options.height + 26;
        back.loadGraphic(Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
        add(back);

        super.create();
    }

    private function p() 
    {
        // FlxG.camera.fade(FlxColor.BLACK, .77, false, () -> {
            FlxG.switchState(new Play());
        // });
    }

    private function b()
    {
        FlxG.switchState(new Start());
    }

    private function o()
    {
        // FlxG.switchState(new Options());
        FlxG.resetState();
    }

    private function r()
    {
        FlxG.resetGame();
    }

}