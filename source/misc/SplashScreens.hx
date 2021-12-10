package misc;

import openfl.system.System;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxSave;
import lime.app.Application;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.Assets;

class SplashScreens extends FlxState
{
	var haxeflixel:FlxText;
  var me:FlxText;
  var randomTextThing:Array<String> = [];
	override public function create()
	{
    randomTextThing = FlxG.random.getObject(rand());
    new FlxTimer().start(1, function(tmr:FlxTimer)
    {
        var backdrop = new FlxBackdrop(Paths.image('hf'));
        backdrop.cameras = [FlxG.camera];
        backdrop.alpha = .3;
        backdrop.velocity.set(150, 150);
    
        var backdrop2 = new FlxBackdrop(Paths.image('sb'));
        backdrop2.cameras = [FlxG.camera];
        backdrop2.alpha = 0;
        backdrop2.velocity.set(0, 150);
      FlxG.camera.zoom += 3;

      FlxTween.tween(camera, {zoom: 1}, .5, {ease: FlxEase.quartInOut});
		  Square.log("test log", false);
      FlxG.sound.playMusic(Paths.music('sw&zka'), 0);
      FlxG.sound.music.fadeIn(4, 0, 1);
		
		  Square.unloadmouse(false);
		  FlxG.camera.fade(FlxColor.BLACK, 0.77, true, function()
		  {
        FlxTween.tween(camera, {zoom: 1.16}, 12.32, {ease: FlxEase.linear});
			  new FlxTimer().start(4.8, function(tmr:FlxTimer)
			  {
          new FlxTimer().start(.77, function(tmr:FlxTimer)
          {
            backdrop.alpha = 0;
            backdrop2.alpha = 1;
            haxeflixel.text = "Made by AllMesi";
            haxeflixel.screenCenter();
            new FlxTimer().start(1.60, function(tmr:FlxTimer)
              {
                haxeflixel.text = randomTextThing[0];
                haxeflixel.screenCenter();
                backdrop.alpha = 0;
                backdrop2.alpha = 0;
                // haxeflixel.alpha = 0;
                new FlxTimer().start(1.15, function(tmr:FlxTimer)
                {
                  haxeflixel.text = randomTextThing[0] + '\n' + randomTextThing[1];
                  new FlxTimer().start(2.5, function(tmr:FlxTimer)
                  {
                    haxeflixel.text = randomTextThing[0];
                    new FlxTimer().start(.5, function(tmr:FlxTimer)
                    {
                      haxeflixel.text = "";
                    });
                      new FlxTimer().start(1, function(tmr:FlxTimer)
                      {
                        FlxG.switchState(new menus.Start());
                      });
                  });
                });
              });
        });
      });
    });

		haxeflixel = new FlxText(0, 0, 0, "Made with Haxeflixel", 10, true);
		haxeflixel.setFormat("_sans", 16, FlxColor.WHITE, CENTER);
		haxeflixel.screenCenter();

    // me = new FlxText(0, 0, 0, "Made by AllMesi", 10, true);
		// me.setFormat("_sans", 16, FlxColor.WHITE, CENTER);
		// me.screenCenter();
		add(backdrop);
    add(backdrop2);
		add(haxeflixel);
    // add(me);
    });
		
		super.create();
	}

	override public function update(elapsed:Float)
	{
    if (FlxG.keys.justPressed.SPACE)
    {
      FlxG.switchState(new menus.Start());
    }
		super.update(elapsed);
	}

  function rand():Array<Array<String>>
  {
    var fullText:String = Assets.getText(Paths.txt('randomText'));
    var firstArray:Array<String> = fullText.split('\n');
    var randomTextArray:Array<Array<String>> = [];

    for (i in firstArray)
    {
      randomTextArray.push(i.split('--'));
    }

    return randomTextArray;
  }
}