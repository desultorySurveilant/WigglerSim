import "Pet.dart";
import 'Stat.dart';
import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:CommonLib/Utility.dart';

import 'dart:async';
import 'dart:html';
import "../Controllers/navbar.dart";




class Grub extends Pet{

  @override
  int millisecondsToChange = 2 * Pet.timeUnit;

  @override
  String type = Pet.GRUB;
  Grub(Doll doll, {health: 100, boredom: 0}) : super(doll, health: health, boredom: boredom) {
    if(doll != null) {
      setEyes();
    }
  }

  void setEyes() {
    //at half way mark, eyes turn yellow like a trolls.
    print("setting eyes for $name");
    if(percentToChange > 0.5) {
      bool force = getParameterByName("eyes",null) == "mutant"; // getParameterByName("eyes",null) == "mutant")
      (doll as HomestuckGrubDoll).mutantEyes(force, true);
    }else {
      HomestuckPalette p = doll.palette as HomestuckPalette;
      p.add(HomestuckPalette.EYE_WHITE_LEFT, p.aspect_light,true);
      p.add(HomestuckPalette.EYE_WHITE_RIGHT, p.aspect_light,true);
    }

    if(corrupt) {
        HomestuckPalette p = doll.palette as HomestuckPalette;
        p.add(HomestuckPalette.EYE_WHITE_LEFT, ReferenceColours.BLACK,true);
        p.add(HomestuckPalette.EYE_WHITE_RIGHT, ReferenceColours.BLACK,true);
    }

    if(purified) {
      HomestuckPalette p = doll.palette as HomestuckPalette;
      p.add(HomestuckPalette.EYE_WHITE_LEFT, ReferenceColours.PURIFIED.eye_white_left,true);
      p.add(HomestuckPalette.EYE_WHITE_RIGHT, ReferenceColours.PURIFIED.eye_white_right,true);
    }
  }

  Grub.fromJSON(String json, [JSONObject jsonObj]) : super(null){
    loadFromJSON(json, jsonObj);
    //print ("loaded $name");
    //at half way mark, eyes turn yellow like a trolls.
    setEyes();
  }




  }