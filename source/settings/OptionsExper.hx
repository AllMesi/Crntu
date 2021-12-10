package settings;

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

class OptionsExper extends FlxSubState
{
	var one:FlxText;
	var bg:FlxSprite;
  var button1 = new FlxButton(0, 0, "Borderless Fullscreen", blfs);    
  var button2 = new FlxButton(0, 50, "Fullscreen", fs);
	var button3 = new FlxButton(0, 100, "Windowed", w);
  var button4 = new FlxButton(0, 100, "Windowed Maximize", wm);
  // var closebrhsefbhg = new FlxButton(1700, 8, "X", closeSettings);
  public function new()
	{
		super();
	}

	override public function create()
	{
		super.create();

		// FlxG.sound.music.pause();
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.fromRGB(88, 88, 88, 255));
    // bg = new FlxSprite(0, 0, misc.Paths.image('ds'));
    bg.y = 1700;
		bg.scrollFactor.set();
		add(bg);
    // var b = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		// b.scrollFactor.set();
    // b.alpha = 0;
		// add(b);
    // var bg = new misc.FlxBackdrop(misc.Paths.image('ds'));
    // bg.cameras = [FlxG.camera];
    // bg.velocity.set(0, 300);
    // bg.alpha = 0;
    // add(bg);

		button1.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/buttonOptions'), true, 80, 29);
        // button1.x = (FlxG.width / 2) - (button1.width / 2);
    button1.x = 200;
    button1.y = 1700;
		// button1.y = (FlxG.height / 2);
		add(button1);

		button2.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/buttonOptions'), true, 80, 20);
        // button2.x = ((FlxG.width / 2) - button2.width / 2);
        button2.x = 200;
        button2.y = 1700;
		// button2.y = (FlxG.height / 2) + button1.height + 3;
		add(button2);

		button3.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/buttonOptions'), true, 80, 20);
		// button3.x = ((FlxG.width / 2) - button3.width / 2);
    button3.x = 200;
    button3.y = 1700;
		// button3.y = (FlxG.height / 2) + button1.height + 26;
		add(button3);

    button4.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/buttonOptions'), true, 80, 20);
		// button3.x = ((FlxG.width / 2) - button3.width / 2);
    button4.x = 200;
    button4.y = 1700;
		// button3.y = (FlxG.height / 2) + button1.height + 26;
		add(button4);

    // var close = new FlxButton(FlxG.width - 28, 8, "X", sdjfhsdkfjh);
  // close.onUp.sound = FlxG.sound.load(Paths.sound('select'));
		// closebrhsefbhg.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/buttonSmallOptions'), true, 20, 20);
		// add(closebrhsefbhg);

		// var button4 = new FlxButton(0, 150, "Back", b);
		// button4.loadGraphic(misc.Paths.image('ui/spritesheets/buttons/button'), true, 80, 20);
    //     button4.x = ((FlxG.width / 2) - button3.width / 2);
		// button4.y = (FlxG.height / 2) + button2.height + 59;
		// add(button4);

		// Square.fps = 30;

		one = new FlxText(0, 0, 0, "Paused", 42);
		one.alpha = 0;
    one.y = 1300;
    one.screenCenter(X);
		one.setFormat('_sans', 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		add(one);
    
		FlxTween.tween(one, {y: one.y - 1300}, .4, {ease: FlxEase.quartInOut});
    // FlxTween.tween(closebrhsefbhg, {x: one.x = FlxG.width - 28}, .4, {ease: FlxEase.quartInOut});
		FlxTween.tween(bg, {alpha: 1, y: bg.y - 1700}, 1, {ease: FlxEase.quartInOut});
    // FlxTween.tween(b, {alpha: 1}, 1, {ease: FlxEase.quartInOut});
    FlxTween.tween(button1, {y: one.y = (FlxG.height / 2)}, .4, {ease: FlxEase.quartInOut});
    FlxTween.tween(button2, {y: one.y = (FlxG.height / 2) + button1.height + 3}, .6, {ease: FlxEase.quartInOut});
    FlxTween.tween(button3, {y: one.y = (FlxG.height / 2) + button1.height + 26}, .8, {ease: FlxEase.quartInOut});
    FlxTween.tween(button4, {y: one.y = (FlxG.height / 2) + button1.height + 52}, 1, {ease: FlxEase.quartInOut});
    // new FlxTimer().start(1, function(tmr:FlxTimer)
    // {
		// 	FlxG.camera.zoom = 1.1;
    //   FlxG.camera.shake(.1, .2);
    //   FlxTween.tween(camera, {zoom: 1}, 1, {ease: FlxEase.quartOut});
    // });
    }
    
    override public function update(elapsed)
      {
        super.update(elapsed);
        
        // if (FlxG.keys.justPressed.Q)
        // {
          // var bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.RED);
          // bg.alpha = 0;
          // bg.scrollFactor.set();
          // // add(bg);
          // // FlxTween.tween(bg, {alpha: 1}, 3.7, {ease: FlxEase.quartInOut});
          // FlxTween.tween(camera, {zoom: 3}, 2, {ease: FlxEase.quartInOut});
          // final pause = new GameOver();
          // openSubState(pause);
          // }
          
          if (FlxG.keys.justPressed.ESCAPE)
          {
            closeSettings();
          }
	}

  public static function blfs()
    {
      Square.setup(true, false, false, false, true, true);
    }    
  
    public static function fs()
    {
      Square.setup(false, true, false, false, true, true);
    }  
  
    public static function w()
    {
      Square.setup(false, false, true, false, true, true);
    }  

    public static function wm()
    {
      Square.setup(false, false, false, true, false, true);
    }


  function closeSettings()
  {
    // FlxTween.tween(closebrhsefbhg, {x: one.x = 1700}, .4, {ease: FlxEase.quartInOut});
    FlxTween.tween(one, {y: one.y + 1300}, .4, {ease: FlxEase.quartInOut});
    FlxTween.tween(bg, {/*alpha: 0, */y: bg.y + 1700}, 1, {ease: FlxEase.quartInOut});
    // FlxTween.tween(bg, {alpha: 0, y: bg.y - 1700}, 1, {ease: FlxEase.quartInOut});
    // FlxTween.tween(b, {alpha: 0}, 1, {ease: FlxEase.quartInOut});
    FlxTween.tween(button1, {y: one.y = 1700}, .8, {ease: FlxEase.quartInOut});
    FlxTween.tween(button2, {y: one.y = 1700}, .6, {ease: FlxEase.quartInOut});
    FlxTween.tween(button3, {y: one.y = 1700}, .4, {ease: FlxEase.quartInOut});
    FlxTween.tween(button4, {y: one.y = 1700}, 1, {ease: FlxEase.quartInOut});
    // Square.fps = 30;
      
    new FlxTimer().start(.8, function(tmr:FlxTimer)
    {
        // FlxG.sound.music.play();
        // Square.fps = 120;
        FlxG.mouse.visible = true;
        FlxG.mouse.enabled = true;
        FlxG.mouse.useSystemCursor = true;
        close();
    });
  }
}