package game;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;

using StringTools;

class Play extends FlxState
{
	public static var curLevel:String = '';

	private var lastBeat:Float = 0;
	private var lastStep:Float = 0;

	var lmao:FlxText;
	var missClickText:FlxText;
	var score:Int;
	var tip:FlxText;
	var healthUp:Bool;
	var misses:Int;
	var missClicks:Int;
	var updatingNotes:Bool;
	var canDie:Bool;
	var canPause:Bool;

	public static var loadText:FlxText;
	public static var bg:FlxSprite;

	private var totalBeats:Int = 0;
	private var totalSteps:Int = 0;

	private var notes:FlxTypedGroup<Note>;
	private var unspawnNotes:Array<Note> = [];

	private var strumLine:FlxSprite;
	private var curSection:Int = 0;

	private var sectionScores:Array<Dynamic> = [[], []];
	private var sectionLengths:Array<Int> = [];

	private var camFollow:FlxObject;
	private var strumLineNotes:FlxTypedGroup<FlxSprite>;

	// private var playerStrums:FlxTypedGroup<FlxSprite>;
	private var camZooming:Bool = false;
	private var camZoomingIntense:Bool = false;
	private var curSong:String = "";

	private var gfSpeed:Int = 1;
	private var health:Float = 1;
	private var combo:Int = 0;

	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;

	private var generatedMusic:Bool = false;
	var fps = new FlxText(0, 0, 0, "FPS", 30, true);
	private var countingDown:Bool = false;

	private var healthHeads:FlxSprite;

	override public function create()
	{
		persistentUpdate = true;
		persistentDraw = true;

		var bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.scrollFactor.set();

		var loadText = new FlxText(0, 0, 0, "Loading...", 30, true);
		loadText.setFormat("Comic Neue Angular Bold", 20, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLUE, true);
		loadText.screenCenter();
		add(loadText);

		fps.setFormat("Comic Neue Angular Bold", 20, FlxColor.GREEN, CENTER);
		fps.screenCenter(X);
		add(fps);

		misses = 0;
		missClicks = 0;
		score = 0;
		totalBeats = 0;
		updatingNotes = true;
		canDie = true;
		canPause = true;
		FlxG.sound.playMusic(Paths.songs('cpp-neko/$curLevel'), 1);

		new FlxTimer().start(.1, function(tmr:FlxTimer)
		{
			// FlxTween.tween(healthBar, {alpha: 1}, 1, {ease: FlxEase.quartInOut});
			// FlxTween.tween(healthBarBG, {alpha: 1}, 1, {ease: FlxEase.quartInOut});
			// FlxTween.tween(lmao, {alpha: 1}, 1, {ease: FlxEase.quartInOut});
			// FlxTween.tween(strumLine, {alpha: 0}, 3, {ease: FlxEase.quartInOut});
			// FlxTween.tween(tip, {alpha: 0}, 3, {ease: FlxEase.quartInOut});
			FlxTween.tween(bg, {alpha: 0}, .30, {ease: FlxEase.quartInOut});
			FlxTween.tween(loadText, {alpha: 0}, 1, {ease: FlxEase.quartInOut});
			// bg.alpha = 0;
			// loadText.alpha = 0;
			// FlxTween.tween(fade, {alpha: 0}, .2, {ease: FlxEase.linear});
			// FlxG.sound.playMusic(Paths.songs('cpp-neko/') + curLevel + ".ogg", 1);
			// if (FlxG.sound.music.playing)
			// {
			// 	FlxG.sound.music.fadeOut(.77, 0);
			// }
			// new FlxTimer().start(3, function(tmr:FlxTimer)
			// {
			//   FlxG.sound.playMusic(Paths.songs('cpp-neko/$curLevel'), 1);
			// });

			Crntu.fps = 0;
			// Crntu.unloadmouse();

			// FlxG.camera.flash(FlxColor.BLACK, .30, function()
			// {
			// 	setup();
			// });

			var timer = new haxe.Timer(1000);
			timer.run = function()
			{
				fps.text = children.Info.currentFPS + "FPS";
				fps.screenCenter(X);
				// if (children.Info.currentFPS > 499)
				// 	fps.setFormat("Comic Neue Angular Bold", 20, FlxColor.GREEN, CENTER);
				// else if (children.Info.currentFPS < 500)
				// 	fps.setFormat("Comic Neue Angular Bold", 20, FlxColor.YELLOW, CENTER);
				// else if (children.Info.currentFPS < 200)
				// 	fps.setFormat("Comic Neue Angular Bold", 20, FlxColor.RED, CENTER);
			}

			var timer2 = new haxe.Timer(30);
			timer2.run = function()
			{
				lmao.text = "Score: " + score + " | Health: " + Math.round(health * 50) + "% | Misses: " + misses;
				lmao.screenCenter(X);
				missClickText.text = "MissClicks: " + missClicks;
			}

			lmao = new FlxText(FlxG.width / 2 - 235, FlxG.height * 0.9 - 20, 0, "", 20);
			lmao.setFormat("Comic Neue Angular Bold", 16, FlxColor.WHITE, CENTER);
			add(lmao);

			missClickText = new FlxText(0, 0, 0, "", 20);
			missClickText.setFormat("Comic Neue Angular Bold", 16, FlxColor.WHITE, CENTER);
			add(missClickText);

			tip = new FlxText(50, 20, 0, "", 20);
			tip.setFormat("Comic Neue Angular Bold", 16, FlxColor.WHITE, CENTER);
			tip.text = "Controls: XC,. | BPM: " + Conductor.bpm;
			add(tip);

			strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);
			strumLine.scrollFactor.set();
			add(strumLine);

			strumLineNotes = new FlxTypedGroup<FlxSprite>();
			add(strumLineNotes);

			// playerStrums = new FlxTypedGroup<FlxSprite>();

			var swagCounter:Int = 0;

			generateSong(curLevel.toLowerCase());
			countingDown = true;
			Conductor.songPosition = 0;
			Conductor.songPosition -= Conductor.crochet * 5;

			// new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
			// {
			// 	switch (swagCounter)
			// 	{
			// 		case 0:
			// 			FlxG.sound.play('assets/sounds/intro3.mp3', 0.6);
			// 		case 1:
			// 			var ready:FlxSprite = new FlxSprite().loadGraphic('assets/images/ready.png');
			// 			ready.scrollFactor.set();
			// 			ready.screenCenter();
			// 			add(ready);
			// 			FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
			// 				ease: FlxEase.cubeInOut,
			// 				onComplete: function(twn:FlxTween)
			// 				{
			// 					ready.destroy();
			// 				}
			// 			});
			// 			FlxG.sound.play('assets/sounds/intro2.mp3', 0.6);
			// 		case 2:
			// 			var set:FlxSprite = new FlxSprite().loadGraphic('assets/images/set.png');
			// 			set.scrollFactor.set();
			// 			set.screenCenter();
			// 			add(set);
			// 			FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
			// 				ease: FlxEase.cubeInOut,
			// 				onComplete: function(twn:FlxTween)
			// 				{
			// 					set.destroy();
			// 				}
			// 			});
			// 			FlxG.sound.play('assets/sounds/intro1.mp3', 0.6);
			// 		case 3:
			// 			var go:FlxSprite = new FlxSprite().loadGraphic('assets/images/go.png');
			// 			go.scrollFactor.set();
			// 			go.screenCenter();
			// 			add(go);
			// 			FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
			// 				ease: FlxEase.cubeInOut,
			// 				onComplete: function(twn:FlxTween)
			// 				{
			// 					go.destroy();
			// 				}
			// 			});
			// 			FlxG.sound.play('assets/sounds/introGo.mp3', 0.6);
			// 		case 4:
			// 	}

			// 	swagCounter += 1;
			// 	generateSong('fresh');
			// }, 5);

			// add(strumLine);

			// camFollow = new FlxObject(0, 0, 1, 1);
			// camFollow.setPosition(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);
			// add(camFollow);

			FlxG.camera.follow(camFollow, LOCKON, 0.04);
			// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
			// FlxG.camera.zoom = 1.05;

			FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

			FlxG.fixedTimestep = false;

			healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.image('ui/game/healthBar'));
			healthBarBG.screenCenter(X);
			healthBarBG.scrollFactor.set();
			// healthBarBG.alpha = 0;
			add(healthBarBG);

			healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
				'health', 0, 2);
			healthBar.scrollFactor.set();
			healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);
			// healthBar.alpha = 0;
			add(healthBar);

			// healthHeads = new FlxSprite();
			// var headTex = FlxAtlasFrames.fromSparrow(AssetPaths.healthHeads__png, AssetPaths.healthHeads__xml);
			// healthHeads.frames = headTex;
			// healthHeads.animation.add('healthy', [0]);
			// healthHeads.animation.add('unhealthy', [1]);
			// healthHeads.y = healthBar.y - (healthHeads.height / 2);
			// healthHeads.scrollFactor.set();
			// add(healthHeads);
		});
		add(bg);
		super.create();
	}

	var debugNum:Int = 0;

	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());
		generatedMusic = true;

		generateStaticArrows(0);
		generateStaticArrows(1);

		var songData = Json.parse(Assets.getText('public/data/' + dataPath + '/' + dataPath + '.json'));
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<Dynamic> = [];

		for (i in 1...songData.sections + 1)
		{
			noteData.push(ChartParser.parse(songData.song.toLowerCase(), i));
		}

		var playerCounter:Int = 0;

		while (playerCounter < 2)
		{
			var daBeats:Int = 0;
			var totalLength:Int = 0;
			for (section in noteData)
			{
				var dumbassSection:Array<Dynamic> = section;

				var daStep:Int = 0;
				var coolSection:Int = Std.int(section.length / 4);

				if (coolSection <= 4)
					coolSection = 4;
				else if (coolSection <= 8)
					coolSection = 8;

				for (songNotes in dumbassSection)
				{
					sectionScores[0].push(0);
					sectionScores[1].push(0);

					if (songNotes != 0)
					{
						var daStrumTime:Float = ((daStep * Conductor.stepCrochet) + (Conductor.crochet * 8 * totalLength))
							+ ((Conductor.crochet * coolSection) * playerCounter);

						var oldNote:Note;
						if (unspawnNotes.length > 0)
							oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
						else
							oldNote = null;

						var swagNote:Note = new Note(daStrumTime, songNotes, oldNote);
						swagNote.scrollFactor.set(0, 0);

						unspawnNotes.push(swagNote);

						swagNote.x += ((FlxG.width / 2) * playerCounter); // general offset

						if (playerCounter == 1) // is the player
						{
							swagNote.mustPress = true;
						}
						else
						{
							sectionScores[0][daBeats] += swagNote.noteScore;
						}
					}

					daStep += 1;
				}

				// only need to do it once
				if (playerCounter == 0)
					sectionLengths.push(Math.round(coolSection / 4));
				totalLength += Math.round(coolSection / 4);
				daBeats += 1;
			}

			Crntu.log('' + unspawnNotes.length);
			playerCounter += 1;
		}

		unspawnNotes.sort(sortByShit);
		Crntu.log('FIRST NOTE ' + unspawnNotes[0]);
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	var sortedNotes:Bool = false;

	private function generateStaticArrows(player:Int):Void
	{
		for (i in 0...4)
		{
			FlxG.log.add(i);
			Crntu.log('$i', false, 'a', false);
			var babyArrow:FlxSprite = new FlxSprite(0, strumLine.y);
			var arrTex = FlxAtlasFrames.fromSparrow(Paths.image('ui/game/spritesheets/notes'), Paths.xml('images/ui/game/spritesheets/notes'));
			babyArrow.frames = arrTex;
			babyArrow.animation.addByPrefix('green', 'arrowUP');
			babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
			babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
			babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

			babyArrow.scrollFactor.set();
			babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));
			babyArrow.updateHitbox();
			// babyArrow.alpha = 0.6;
			babyArrow.antialiasing = true;

			babyArrow.y -= 10;
			// babyArrow.x -= 273;
			babyArrow.alpha = 0;
			// FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			// FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: .8}, .5, {ease: FlxEase.elasticInOut, startDelay: 0.5 + (0.2 * i)});
			FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: .8}, .5, {ease: FlxEase.elasticInOut});

			babyArrow.ID = i + 1;

			// if (player == 0)
			// {
			FlxG.sound.play(Paths.soundwav('drum'), .2, false);
			// playerStrums.add(babyArrow);
			// }

			switch (Math.abs(i + 1))
			{
				case 1:
					babyArrow.x += Note.swagWidth * 2;
					babyArrow.animation.addByPrefix('static', 'arrowUP');
					babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
				// babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
				case 2:
					babyArrow.x += Note.swagWidth * 3;
					babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
					babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
				// babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
				case 3:
					babyArrow.x += Note.swagWidth * 1;
					babyArrow.animation.addByPrefix('static', 'arrowDOWN');
					babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
				// babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
				case 4:
					babyArrow.x += Note.swagWidth * 0;
					babyArrow.animation.addByPrefix('static', 'arrowLEFT');
					babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
					// babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
			}

			babyArrow.animation.play('static');
			babyArrow.x += 50;
			babyArrow.x += ((FlxG.width / 2) * player);

			strumLineNotes.add(babyArrow);
			Crntu.log('added an arrow or whatever');
		}
		Crntu.log('added an arrow or whatever');
	}

	// var sectionScored:Bool = false;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (updatingNotes)
		{
			Conductor.songPosition += FlxG.elapsed * 1000;
		}

		// else
		// {
		// 	lmao.text = "stats unavailable due to notes not updating";
		// 	lmao.screenCenter(X);
		// }

		#if debug
		if (FlxG.keys.pressed.D && FlxG.keys.justPressed.E)
		{
			final pause = new subStates.PlayDebugSettings();
			openSubState(pause);
		}
		#end

		if (FlxG.keys.justPressed.R)
		{
			FlxG.resetState();
		}

		if (!FlxG.keys.pressed.ALT && FlxG.keys.justPressed.ENTER && canPause)
		{
			persistentUpdate = false;
			persistentDraw = true;

			final pause = new subStates.PauseSub();
			openSubState(pause);
		}

		// healthHeads.setGraphicSize(Std.int(FlxMath.lerp(100, healthHeads.width, 0.98)));
		// healthHeads.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (healthHeads.width / 2);

		// if (healthBar.percent < 10)
		// 	healthHeads.animation.play('unhealthy');
		// else
		// 	healthHeads.animation.play('healthy');
		/* 
			if (FlxG.keys.justPressed.NINE)
				FlxG.switchState(new Charting());
			if (FlxG.keys.justPressed.EIGHT)
				FlxG.switchState(new Charting(true));
		 */

		// if (countingDown)
		// {
		// Conductor.songPosition += FlxG.elapsed * 1000;

		// startSong();
		// }
		// else
		// Conductor.songPosition = FlxG.sound.music.time;
		// var playerTurn:Int = totalBeats % (sectionLengths[curSection] * 8);

		// if (playerTurn == (sectionLengths[curSection] * 8) - 1 && !sectionScored)
		// {
		// 	popUpScore();
		// 	sectionScored = true;
		// }

		// if (playerTurn == 0 && generatedMusic)
		// {
		// 	if (camFollow.x != dad.getGraphicMidpoint().x + 150)
		// 		camFollow.setPosition(dad.getGraphicMidpoint().x + 150, dad.getGraphicMidpoint().y - 100);
		// 	vocals.volume = 1;
		// }

		// if (playerTurn == Std.int((sectionLengths[curSection] * 8) / 2) && camFollow.x != boyfriend.getGraphicMidpoint().x - 100)
		// {
		// 	camFollow.setPosition(boyfriend.getGraphicMidpoint().x - 100, boyfriend.getGraphicMidpoint().y - 100);
		// }

		// if (camZooming)
		// {
		// 	FlxG.camera.zoom = FlxMath.lerp(1.00, FlxG.camera.zoom, 0.96);
		// }

		if (camZoomingIntense)
		{
			FlxG.camera.zoom = FlxMath.lerp(1.00, FlxG.camera.zoom, 0.96);
		}

		// if (playerTurn < 4)
		// {
		// 	sectionScored = false;
		// }

		FlxG.watch.addQuick("beatShit", totalBeats);

		// if (curSong == 'TheDrop')
		// {
		// 	switch (totalBeats)
		// 	{
		// 		case 347:
		// 			Crntu.songNext('bopeebo');
		// 	}
		// }

		if (curSong == 'Classical')
		{
			switch (totalBeats)
			{
				case 29:
					trace('shake??');
					FlxG.camera.shake(.05, 2);
			}
		}

		// if (curSong == 'Bopeebo')
		// {
		// 	switch (totalBeats)
		// 	{
		// 		case 127:
		// 			Crntu.songStart('fresh', 100);
		// 	}
		// }

		// if (curSong == 'Fresh')
		// {
		// 	switch (totalBeats)
		// 	{
		// 		case 0:
		// 			camZoomingIntense = true;
		// 		case 16:
		// 			camZoomingIntense = false;
		// 			totalBeats = 0;
		// 			camZooming = true;
		// 	}
		// }

		everyBeat();
		everyStep();
		everyBeatIntense();

		if (health <= 0)
		{
			if (canDie)
			{
				var bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.RED);
				bg.alpha = 0;
				bg.scrollFactor.set();
				// add(bg);
				updatingNotes = false;
				// FlxTween.tween(bg, {alpha: 1}, 3.7, {ease: FlxEase.quartInOut});
				FlxTween.tween(camera, {zoom: 3}, 2, {ease: FlxEase.quartInOut});
				canDie = false;
				canPause = false;
				final pause = new subStates.GameOver();
				openSubState(pause);
			}
		}

		if (health >= 2)
		{
			health == 2;
		}

		if (unspawnNotes[0] != null)
		{
			FlxG.watch.addQuick('spsa', unspawnNotes[0].strumTime);
			FlxG.watch.addQuick('weed', Conductor.songPosition);

			if (unspawnNotes[0].strumTime - Conductor.songPosition < 1500)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.add(dunceNote);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		if (generatedMusic)
		{
			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.y > FlxG.height)
				{
					daNote.active = false;
					daNote.visible = false;
				}
				else
				{
					daNote.visible = true;
					daNote.active = true;
				}

				if (!daNote.mustPress && daNote.wasGoodHit)
				{
					daNote.kill();
					notes.remove(daNote, true);
					daNote.destroy();
				}

				daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * 0.45);

				if (daNote.y < -daNote.height)
				{
					if (daNote.tooLate)
					{
						noteMiss();
					}

					daNote.active = false;
					daNote.visible = false;

					daNote.kill();
					notes.remove(daNote, true);
					daNote.destroy();
				}

				// one time sort
				if (!sortedNotes)
					notes.sort(FlxSort.byY, FlxSort.DESCENDING);
			});
		}
		noteKeys();
	}

	private function popUpScore():Void
	{
		// boyfriend.playAnim('hey');
		// vocals.volume = 1;

		var placement:String = Std.string(combo);
		// var placement:String = sectionScores[1][curSection] + '/' + sectionScores[0][curSection];

		var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
		coolText.screenCenter();
		coolText.x = FlxG.width * 0.75;
		//

		var rating:FlxSprite = new FlxSprite();

		var daRating:String = "shit";

		if (combo > 60)
			daRating = 'sick';
		else if (combo > 12)
			daRating = 'good'
		else if (combo > 4)
			daRating = 'bad';
		// rating.loadGraphic('assets/images/' + daRating + ".png");
		// rating.screenCenter();
		// rating.x = coolText.x - 40;
		// rating.y -= 60;
		// rating.acceleration.y = 550;
		// rating.velocity.y -= FlxG.random.int(140, 175);
		// rating.setGraphicSize(Std.int(rating.width * 0.7));
		// rating.updateHitbox();
		// rating.antialiasing = true;
		// rating.velocity.x -= FlxG.random.int(0, 10);

		// var comboSpr:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.combo__png);
		// comboSpr.screenCenter();
		// comboSpr.x = coolText.x;
		// comboSpr.acceleration.y = 600;
		// comboSpr.antialiasing = true;
		// comboSpr.velocity.y -= 150;
		// comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
		// comboSpr.updateHitbox();
		// comboSpr.velocity.x += FlxG.random.int(1, 10);
		// add(comboSpr);
		// add(rating);

		var seperatedScore:Array<Int> = [];

		seperatedScore.push(Math.floor(combo / 100));
		seperatedScore.push(Math.floor((combo - (seperatedScore[0] * 100)) / 10));
		seperatedScore.push(combo % 10);

		var daLoop:Int = 0;
		for (i in seperatedScore)
		{
			var numScore:FlxSprite = new FlxSprite().loadGraphic('assets/images/num' + Std.int(i) + '.png');
			numScore.screenCenter();
			numScore.x = coolText.x + (43 * daLoop) - 90;
			numScore.y += 80;
			numScore.antialiasing = true;
			numScore.setGraphicSize(Std.int(numScore.width * 0.5));
			numScore.updateHitbox();
			numScore.acceleration.y = FlxG.random.int(200, 300);
			numScore.velocity.y -= FlxG.random.int(140, 160);
			numScore.velocity.x = FlxG.random.float(-5, 5);
			add(numScore);

			FlxTween.tween(numScore, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					numScore.destroy();
				},
				startDelay: Conductor.crochet * 0.002
			});

			daLoop++;
		}

		Crntu.log('' + combo);
		Crntu.log('' + seperatedScore);

		coolText.text = Std.string(seperatedScore);
		// add(coolText);

		FlxTween.tween(rating, {alpha: 0}, 0.2, {
			startDelay: Conductor.crochet * 0.001
		});

		// FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
		// 	onComplete: function(tween:FlxTween)
		// 	{
		// 		coolText.destroy();
		// 		comboSpr.destroy();

		// 		rating.destroy();
		// 	},
		// 	startDelay: Conductor.crochet * 0.001
		// });

		curSection += 1;
	}

	private function noteKeys():Void
	{
		// HOLDING
		var up = FlxG.keys.anyPressed([W, UP, COMMA]);
		var right = FlxG.keys.anyPressed([D, RIGHT, PERIOD]);
		var down = FlxG.keys.anyPressed([S, DOWN, C]);
		var left = FlxG.keys.anyPressed([A, LEFT, X]);

		var upP = FlxG.keys.anyJustPressed([W, UP, COMMA]);
		var rightP = FlxG.keys.anyJustPressed([D, RIGHT, PERIOD]);
		var downP = FlxG.keys.anyJustPressed([S, DOWN, C]);
		var leftP = FlxG.keys.anyJustPressed([A, LEFT, X]);

		var upR = FlxG.keys.anyJustReleased([W, UP, COMMA]);
		var rightR = FlxG.keys.anyJustReleased([D, RIGHT, PERIOD]);
		var downR = FlxG.keys.anyJustReleased([S, DOWN, C]);
		var leftR = FlxG.keys.anyJustReleased([A, LEFT, X]);

		// FlxG.watch.addQuick('asdfa', upP);
		if ((upP || rightP || downP || leftP) && generatedMusic)
		{
			var possibleNotes:Array<Note> = [];

			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate)
				{
					possibleNotes.push(daNote);
					Crntu.log('NOTE-' + daNote.strumTime + ' ADDED');
				}
			});

			if (possibleNotes.length > 0)
			{
				for (daNote in possibleNotes)
				{
					switch (daNote.noteData)
					{
						case 1: // NOTES YOU JUST PRESSED
							if (upP || rightP || downP || leftP)
								noteCheck(upP, daNote);
						case 2:
							if (upP || rightP || downP || leftP)
								noteCheck(rightP, daNote);
						case 3:
							if (upP || rightP || downP || leftP)
								noteCheck(downP, daNote);
						case 4:
							if (upP || rightP || downP || leftP)
								noteCheck(leftP, daNote);
					}

					if (daNote.wasGoodHit)
					{
						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();
					}
				}
			}
			else
			{
				if (updatingNotes)
				{
					FlxG.sound.play(Paths.soundwav('drum'), .2, false);
					missClick();
				}
			}
		}

		if ((up || right || down || left) && generatedMusic)
		{
			notes.forEach(function(daNote:Note)
			{
				if (daNote.canBeHit && daNote.mustPress)
				{
					switch (daNote.noteData)
					{
						// NOTES YOU ARE HOLDING
						case -1:
							if (up && daNote.prevNote.wasGoodHit)
								goodNoteHit(daNote);
						case -2:
							if (right && daNote.prevNote.wasGoodHit)
								goodNoteHit(daNote);
						case -3:
							if (down && daNote.prevNote.wasGoodHit)
								goodNoteHit(daNote);
						case -4:
							if (left && daNote.prevNote.wasGoodHit)
								goodNoteHit(daNote);
					}
				}
			});
		}

		// playerStrums.forEach(function(spr:FlxSprite)
		// {
		// 	switch (spr.ID)
		// 	{
		// 		case 1:
		// 			if (upP && spr.animation.curAnim.name != 'confirm')
		// 				spr.animation.play('pressed');
		// 			if (upR)
		// 				spr.animation.play('static');
		// 		case 2:
		// 			if (rightP && spr.animation.curAnim.name != 'confirm')
		// 				spr.animation.play('pressed');
		// 			if (rightR)
		// 				spr.animation.play('static');
		// 		case 3:
		// 			if (downP && spr.animation.curAnim.name != 'confirm')
		// 				spr.animation.play('pressed');
		// 			if (downR)
		// 				spr.animation.play('static');
		// 		case 4:
		// 			if (leftP && spr.animation.curAnim.name != 'confirm')
		// 				spr.animation.play('pressed');
		// 			if (leftR)
		// 				spr.animation.play('static');
		// 	}

		// 	if (spr.animation.curAnim.name == 'confirm')
		// 	{
		// 		spr.centerOffsets();
		// 		spr.offset.x -= 13;
		// 		spr.offset.y -= 13;
		// 	}
		// 	else
		// 		spr.centerOffsets();
		// });
	}

	function noteMiss():Void
	{
		health -= 0.04;
		if (combo >= 5 && combo < 10)
		{
			FlxTween.tween(healthBar, {alpha: .3}, .5, {ease: FlxEase.quartInOut});
			FlxTween.tween(healthBarBG, {alpha: .3}, .5, {ease: FlxEase.quartInOut});
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				FlxTween.tween(healthBar, {alpha: 1}, .5, {ease: FlxEase.quartInOut});
				FlxTween.tween(healthBarBG, {alpha: 1}, .5, {ease: FlxEase.quartInOut});
			});
		}
		else if (combo >= 10)
		{
			FlxG.camera.shake(1, .1);
			FlxG.camera.flash(FlxColor.RED, 1);
			FlxTween.tween(healthBar, {alpha: .3}, .5, {ease: FlxEase.quartInOut});
			FlxTween.tween(healthBarBG, {alpha: .3}, .5, {ease: FlxEase.quartInOut});
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				FlxTween.tween(healthBar, {alpha: 1}, .5, {ease: FlxEase.quartInOut});
				FlxTween.tween(healthBarBG, {alpha: 1}, .5, {ease: FlxEase.quartInOut});
			});
		}
		combo = 0;
		misses += 1;
		score -= 23;
	}

	function missClick()
	{
		if (updatingNotes)
		{
			// if (missClicks != null)
			// {
			FlxTween.tween(missClickText, {alpha: 1}, .4, {ease: FlxEase.quartInOut});
			score -= 1;
			missClicks += 1;
			new FlxTimer().start(3, function(tmr:FlxTimer)
			{
				FlxTween.tween(missClickText, {alpha: 0}, 1, {ease: FlxEase.quartInOut});
			});
			// }
			if (missClicks >= 200)
			{
				Crntu.fps = 30;
				new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					Crntu.fps = 0;
				});
			}
			if (missClicks >= 500)
			{
				FlxTween.tween(missClickText, {alpha: 1}, .4, {ease: FlxEase.quartInOut});
				FlxG.camera.flash(FlxColor.RED, .5);
				score -= 10;
				missClicks += 2;
				misses += 2;
				new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					FlxTween.tween(missClickText, {alpha: 0}, 1, {ease: FlxEase.quartInOut});
				});
				var bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.RED);
				bg.alpha = 0;
				bg.scrollFactor.set();
				add(bg);
				FlxTween.tween(healthBar, {alpha: .3}, .5, {ease: FlxEase.quartInOut});
				FlxTween.tween(healthBarBG, {alpha: .3}, .5, {ease: FlxEase.quartInOut});
				FlxTween.tween(bg, {alpha: 0.3}, 0.4, {ease: FlxEase.quartInOut});
				new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					FlxTween.tween(healthBar, {alpha: 1}, .5, {ease: FlxEase.quartInOut});
					FlxTween.tween(healthBarBG, {alpha: 1}, .5, {ease: FlxEase.quartInOut});
					FlxTween.tween(bg, {alpha: 0}, 0.4, {ease: FlxEase.quartInOut});
				});
			}
		}
	}

	function setup()
	{
		misses = 0;
		missClicks = 0;
		score = 0;
		totalBeats = 0;
		updatingNotes = true;
		canDie = true;
		canPause = true;
		FlxG.sound.playMusic(Paths.songs('cpp-neko/$curLevel'), 1);
		// FlxTween.tween(healthBar, {alpha: 1}, 1, {ease: FlxEase.quartInOut});
		// FlxTween.tween(healthBarBG, {alpha: 1}, 1, {ease: FlxEase.quartInOut});
		// FlxTween.tween(lmao, {alpha: 1}, 1, {ease: FlxEase.quartInOut});
		// if (updatingNotes)
		// {
		// 	FlxTween.tween(missClickText, {alpha: 0}, 1, {ease: FlxEase.quartInOut});
		// }
		// FlxTween.tween(strumLine, {alpha: 0}, 3, {ease: FlxEase.quartInOut});
		// FlxTween.tween(tip, {alpha: 0}, 3, {ease: FlxEase.quartInOut});
	}

	function badNoteCheck()
	{
		// just double pasting this shit cuz fuk u
		var upP = FlxG.keys.anyJustPressed([W, UP]);
		var rightP = FlxG.keys.anyJustPressed([D, RIGHT]);
		var downP = FlxG.keys.anyJustPressed([S, DOWN]);
		var leftP = FlxG.keys.anyJustPressed([A, LEFT]);

		noteMiss();
	}

	function noteCheck(keyP:Bool, note:Note):Void
	{
		FlxG.sound.play(Paths.soundwav('drum'), .2, false);
		Crntu.log(note.noteData + ' note check here ' + keyP);
		if (keyP)
			goodNoteHit(note);
		else
			badNoteCheck();
	}

	function goodNoteHit(note:Note):Void
	{
		if (!note.wasGoodHit)
		{
			combo += 1;
			score += 57;

			if (note.noteData > 0)
				health += 0.03;
			else
				health += 0.007;

			// playerStrums.forEach(function(spr:FlxSprite)
			// {
			// 	if (Math.abs(note.noteData) == spr.ID)
			// 	{
			// 		spr.animation.play('confirm', true);
			// 	}
			// });

			sectionScores[1][curSection] += note.noteScore;
			note.wasGoodHit = true;

			note.kill();
			notes.remove(note, true);
			note.destroy();
		}
	}

	private function everyBeatIntense():Void
	{
		if (Conductor.songPosition > lastBeat + Conductor.crochet - Conductor.safeZoneOffset
			|| Conductor.songPosition < lastBeat + Conductor.safeZoneOffset)
		{
			if (Conductor.songPosition > lastBeat + Conductor.crochet)
			{
				lastBeat += Conductor.crochet;

				if (camZoomingIntense && FlxG.camera.zoom < 1.35 && totalBeats % 1 == 0)
					FlxG.camera.zoom += 0.050;

				totalBeats += 1;
			}
		}
	}

	private function everyBeat():Void
	{
		if (Conductor.songPosition > lastBeat + Conductor.crochet - Conductor.safeZoneOffset
			|| Conductor.songPosition < lastBeat + Conductor.safeZoneOffset)
		{
			if (Conductor.songPosition > lastBeat + Conductor.crochet)
			{
				lastBeat += Conductor.crochet;

				// if (camZooming && FlxG.camera.zoom < 1.35 && totalBeats % 2 == 0)
				// 	FlxG.camera.zoom += 0.024;

				if (camZooming && totalBeats % 2 == 0)
          FlxG.camera.zoom += 0.054;

					totalBeats += 1;
			}
		}
	}

	private function everyStep():Void
	{
		if (Conductor.songPosition > lastStep + Conductor.stepCrochet - Conductor.safeZoneOffset
			|| Conductor.songPosition < lastStep + Conductor.safeZoneOffset)
		{
			if (Conductor.songPosition > lastStep + Conductor.stepCrochet)
			{
				totalSteps += 1;
				lastStep += Conductor.stepCrochet;
			}
		}
	}

	public function new()
	{
		super();
		trace('line 1117');
	}
}
