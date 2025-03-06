package states;

import backend.WeekData;
import backend.Highscore;
import backend.Song;

import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;
import flixel.FlxG;

class HuggyMenuState extends MusicBeatState {
    

    var newGameButton:FlxSprite;
    var creditsButton:FlxSprite;
    var settButton:FlxSprite;


    var loadedWeeks:Array<WeekData> = [];
    private static var curWeek:Int = 0;
    


    override function create() {
        super.create();

        var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("modMainMenu/menu"));
        bg.frames = Paths.getSparrowAtlas("modMainMenu/menu");
        bg.animation.addByPrefix("idle", "menu idle", 24, true);
        bg.antialiasing = true;
        add(bg);

        bg.animation.play("idle");

        newGameButton = new FlxSprite(10, 386).loadGraphic(Paths.image("modMainMenu/NewGame"));
        newGameButton.antialiasing = false;
        add(newGameButton);
        
        settButton = new FlxSprite(10, 497).loadGraphic(Paths.image("modMainMenu/Settings"));
        settButton.antialiasing = false;
        add(settButton);

        creditsButton = new FlxSprite(10, 608).loadGraphic(Paths.image("modMainMenu/Credits"));
        creditsButton.antialiasing = false;
        add(creditsButton);

    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.mouse.justReleased && newGameButton.overlapsPoint(FlxG.mouse.getScreenPosition()))
            {
                        // We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
                        var songArray:Array<String> = [];
                        var leWeek:Array<Dynamic> = loadedWeeks[curWeek].songs;
                        for (i in 0...leWeek.length) {
                            songArray.push(leWeek[i][0]);
                        }
            
                        // Nevermind that's stupid lmao
                        try
                        {
                            PlayState.storyPlaylist = songArray;
                            PlayState.isStoryMode = true;
                
                            var diffic = '';
                            if(diffic == null) diffic = '';
                
                
                            PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
                            PlayState.campaignScore = 0;
                            PlayState.campaignMisses = 0;
                        }
                        catch(e:Dynamic)
                        {
                            trace('ERROR! $e');
                            return;
                        }
            }
    }
}
