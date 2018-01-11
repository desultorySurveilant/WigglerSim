/*
    An ai pet has a pet inside of it, as well as a list of animations it can play. and an idea of when to play them.
    also has x/y rotation and scale
    Use cases:
        Trigger: Pet has nothing better to do
            Action: idle animation (flip between two similar bodies)
        Trigger: Pet wants to investigate an object that is not near by.
            Action: Walk animation to object's x/y coordinates. (flip between two similar bodies, change x coordinates)
        Trigger: Pet wants to investigate an object close by.
            Action: display chosen emoticon or text (age based), idle animation as well
        Trigger: Pet wants to attack an object close by.
            Action: figure out some attack animation. play that. item removed from playpen by jadeblood.

    Now, I also need to figure out how stats are going to effect AI. I might need to use the debug_rambling page
    for some solid ideas. But I can probably get the idle animation started for now.



 */
import 'dart:async';
import "../Pets/PetLib.dart";
import 'dart:html';
import 'dart:math' as Math;
import 'dart:async';
import 'package:DollLibCorrect/DollRenderer.dart';


abstract class AIObject {
    int id;
    int x;
    int y;
    bool turnWays = false;
    double scaleX = 1.0;
    double scaleY = 1.0;
    double rotation = 0.0;
    Stat patience;
    Stat energetic;
    Stat idealistic;
    Stat curious;
    Stat loyal;
    Stat external;
    List<Stat> get stats => <Stat>[patience, energetic, idealistic, curious, loyal, external ];

    AnimationObject idleAnimation = new AnimationObject();



    AIObject({int this.x: 0, int this.y: 100}) {
    }

    //https://codereview.stackexchange.com/questions/107635/checking-if-two-numbers-have-the-same-sign
    bool sameSign(int num1, int num2) {
       // print("similarity rating: does $num1 have the same sign as $num2? ${(num1 ^ num2) >= 0}");
        return (num1 ^ num2) >= 0;
    }

    @override
    String toString() {
        return "AiObject";
    }

    static int distance(int x1, int y1, int x2, int y2) {
        int xs = (x1-x2)^2;
        int ys = (y1-y2)^2;
        //print("xs $xs ys $ys");
        return Math.sqrt((xs+ys).abs()).round();

    }

    int distanceFromTarget(AIObject target) {
        return distance(target.x, target.y, x, y);
    }

    int similarityRating(AIObject obj) {
       // print("getting similarity rating between ${this} and ${obj}");

        int similarity = 0;
        //for each stat we have the same value for, add a point
        //for objects, assume stat of zero means neither way
        if(obj.patience.value != 0 && sameSign(patience.value, obj.patience.value)) {
            similarity ++;
        }else if(obj.patience.value != 0)  {
            similarity += -1;
        }
        if(obj.curious.value != 0 && sameSign(curious.value, obj.curious.value)){
            similarity ++;
        }else if(obj.curious.value != 0) {
            similarity += -1;
        }
        if(obj.energetic.value != 0 &&sameSign(energetic.value, obj.energetic.value)){
            similarity ++;
        }else if(obj.energetic.value != 0)  {
            similarity += -1;
        }
        if(obj.idealistic.value != 0 &&sameSign(idealistic.value, obj.idealistic.value)){
            similarity ++;
        }else if(obj.idealistic.value != 0)  {
            similarity += -1;
        }
        if(obj.loyal.value != 0 &&sameSign(loyal.value, obj.loyal.value)){ similarity ++;
        }else if(obj.loyal.value != 0)  {
            similarity += -1;
        }
        if(obj.external.value != 0 &&sameSign(external.value, obj.external.value)){
            similarity ++;
        }else if(obj.external.value != 0) {
            similarity += -1;
        }
        print("similarity rating between ${this} and ${obj} is $similarity");
        return similarity;
    }

    //grub body 0 and grub body 1
    Future<Null> setUpIdleAnimation() async
    {

    }


    Future<Null> draw(CanvasElement canvas) async {


    }




}



class AnimationObject {
    List<CanvasElement> animations = new List<CanvasElement>();
    int index = 0;

    void addAnimationFrame(CanvasElement canvas, [int index = -13]) {
        //print("adding animation frame");
        if(index >= 0) {
            animations[index] = canvas;
        }else {
            animations.add(canvas);
        }
    }

    CanvasElement getNextFrame() {
        index ++;
        if(index >= animations.length) {
            index = 0;
        }
        //print("next frame is $index, so that's ${animations[index]}");
        return animations[index];
    }



}