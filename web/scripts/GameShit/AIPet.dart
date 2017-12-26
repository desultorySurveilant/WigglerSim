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
import 'dart:async';
import 'package:DollLibCorrect/DollRenderer.dart';


class AIPet {
    int x;
    int y;
    double _scaleX = 1.0;
    double _scaleY = 1.0;
    double rotation = 0.0;
    Grub grub;
    AnimationObject idleAnimation = new AnimationObject();

    AIPet(Grub this.grub, {int this.x: 0, int this.y: 100}) {
    }

    //grub body 0 and grub body 1
    Future<Null> setUpIdleAnimation() async {
        HomestuckGrubDoll g = grub.doll;
        Random rand = new Random();
        rand.nextInt(10); //init
        if(rand.nextBool()) {
            g.body.imgNumber = 0;
            await grub.draw();
            idleAnimation.addAnimationFrame(grub.canvas);
            grub.canvas = null; //means it will make a new one, so old reference is free
            g.body.imgNumber = 1;
            await grub.draw();
            idleAnimation.addAnimationFrame(grub.canvas);
        }else { //so they don't all look the same
            g.body.imgNumber = 1;
            await grub.draw();
            idleAnimation.addAnimationFrame(grub.canvas);
            grub.canvas = null; //means it will make a new one, so old reference is free
            g.body.imgNumber = 0;
            await grub.draw();
            idleAnimation.addAnimationFrame(grub.canvas);
        }
    }

    Future<Null> draw(CanvasElement canvas) async {
        //TODO figure out more complex things than standing in one spot and twitching later.
        //TODO figure out how i want to do text, emoticons, scale and rotation.
        CanvasElement frame = idleAnimation.getNextFrame();
        print("frame is $frame and canvas is $canvas");
        canvas.context2D.drawImage(frame,x,y);
    }


    void getPositiveEmotion() {
        //TODO
    }

    //some grubs get scared, others get angry
    void getNegativeEmotion() {
        //TODO
    }

    //given my stats, do i like things i've seen before?
    bool likesFamiliar() {
        throw "TODO";
    }

    //given my stats, do i like things similar to me?
    bool likesSimilar() {
        throw "TODO";
    }

    //can be positive or negative about an object
    bool judgeObject() {
        /*
            TODO: Take in an AIObject
            First it judges how similar the object is to me.
    Then it decides whether similarity is a good or bad thing.

    THEN it checks the grubs memory to see if it's seen that object before
        (item name or stat match, both work, so it means you like familiar things even if you
        haven't seen that exact thing before)

    Then it decides whether familiarity is a good or bad thing.

        */
    }


}


class AnimationObject {
    List<CanvasElement> animations = new List<CanvasElement>();
    int index = 0;

    void addAnimationFrame(CanvasElement canvas, [int index = -13]) {
        print("adding animation frame");
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
        print("next frame is $index, so that's ${animations[index]}");
        return animations[index];
    }



}