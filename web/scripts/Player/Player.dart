//a player has an inventory.
// a player has a doll.
//a player has a graduatesList.
import 'package:DollLibCorrect/DollRenderer.dart';
import "PetInventory.dart";
import 'dart:html';
import 'package:json_object/json_object.dart';
import 'dart:async';
import 'dart:convert';

class Player {
    static String DATASTRING = "dataString";
    static String LASTPLAYED = "lastPlayed";
    static String DOLLSAVEID = "WigglerCaretaker";

    Doll doll;
    CanvasElement canvas;
    int width = 400;
    int height = 300;

    PetInventory petInventory;


    static int minJadeSign = 121;
    static int maxJadeSign = 144;
    DateTime lastPlayed;
    DateTime oldLastPlayed;

    Player.fromJSON(String json){
        loadFromJSON(json);
    }

     void loadFromJSON(String json) {
        JsonObject jsonObj = new JsonObject.fromJsonString(json);
        String dataString = jsonObj[DATASTRING];
        String lastPlayedString = jsonObj[LASTPLAYED];
        doll = Doll.loadSpecificDoll(dataString);
        oldLastPlayed = new DateTime.fromMillisecondsSinceEpoch(int.parse(lastPlayedString));
    }

    String get daysSincePlayed {
        DateTime now = new DateTime.now();
        Duration diff = now.difference(oldLastPlayed);
        //print("hatch date is $hatchDate and diff is $diff");
        if(diff.inDays > 0) {
            return "You last checked on the wigglers ${diff.inDays} days ago. Shit. I hope they are okay.";
        }else if (diff.inHours > 0) {
            return "You last checked on the wigglers ${diff.inHours} hours ago. You're pretty good at your job.";
        }else if (diff.inMinutes > 0) {
            return "You last checked on the wigglers ${diff.inMinutes} minutes ago. I guess it can't hurt to see what they are up to.";
        }else if (diff.inSeconds > 0) {
            return "You last checked on the wigglers ${diff.inSeconds} seconds ago. You know they'll be okay on their own, right?";
        }
        return "Welcome Back!";
    }

    Player(this.doll, [bool makeJade = true]) {
        lastPlayed = new DateTime.now();
        if(makeJade && doll is HomestuckTrollDoll) {
            HomestuckTrollDoll troll = doll as HomestuckTrollDoll;
            Random rand = new Random();
            int signNumber = rand.nextInt(maxJadeSign - minJadeSign) + minJadeSign;
            troll.canonSymbol.imgNumber = signNumber;
            troll.randomize(false);
            print("canon symbol set to ${troll.canonSymbol.imgNumber} which should be jade");
        }
        //TODO create the pet inventory from json. have a .fromJSON constructor for player
        petInventory = new PetInventory();
    }

    void displayloadBoxAndText(Element div)
    {
        Element container = new DivElement();
        String text = "Your name is UNIMPORTANT. What IS important is that you are a JADE BLOOD assigned to the BROODING CAVERNS. You are new to your duties, but are SUDDENLY CERTAIN that you will be simply the best there is at RAISING WIGGLERS. ${daysSincePlayed} ((TODO: change text based on stage))";
        Element container2 = new DivElement();
        String text2 = "<br><Br>Or are you? Maybe you are someone else? ";
        AnchorElement link = new AnchorElement();
        link.href = "http://www.farragofiction.com/DollSim/troll_index.html";
        link.text = " Anybody in mind?";
        link.style.padding = "padding:10px";

        Element container3 = new DivElement();
        TextAreaElement dollLoader = new TextAreaElement();
        dollLoader.cols = 30;
        dollLoader.rows = 9;
        dollLoader.text = doll.toDataBytesX();
        dollLoader.style.padding = "padding:10px";
        container3.append(dollLoader);
        Element container4 = new DivElement();
        ButtonElement button = new ButtonElement();
        button.text = "Load Doll";
        button.onClick.listen((Event e) {
            print("current doll is $doll");
            doll = Doll.loadSpecificDoll(dollLoader.value);
            print("new doll is $doll");

            save();
            draw();
        });

        container4.append(button);


        container.appendHtml(text);
        container2.appendHtml(text2);
        container2.append(link);
        div.append(container);
        div.append(container2);
        div.append(container3);
        div.append(container4);

    }


    //TODO convert self to json (including pet inventory) to save in this localStorage
    void save() {
        String json = toJson().toString();
        print("storing ${json}");
        window.localStorage[DOLLSAVEID] = json;
    }


    //TODO probably need to spend time thining of what needs to happen here. should i cache canvas?
    Future<CanvasElement> draw() async {
        if(canvas == null) canvas = new CanvasElement(width: width, height: height);
        canvas.context2D.clearRect(0,0,width,height);
        CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);
        await Renderer.drawDoll(dollCanvas, doll);

        dollCanvas = Renderer.cropToVisible(dollCanvas);

        Renderer.drawToFitCentered(canvas, dollCanvas);
        return canvas;
    }

    JsonObject toJson() {
        lastPlayed = new DateTime.now();
        JsonObject json = new JsonObject();
        json[DATASTRING] = doll.toDataBytesX();
        json[LASTPLAYED] = "${lastPlayed.millisecondsSinceEpoch}";
        //TODO also add json array of all pets
        return json;
    }
}