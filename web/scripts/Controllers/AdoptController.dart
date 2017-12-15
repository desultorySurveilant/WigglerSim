import 'dart:html';
import 'package:DollLibCorrect/DollRenderer.dart';
import 'dart:async';
import '../GameShit/GameObject.dart';
import "navbar.dart";
GameObject game;

void main() {
    loadNavbar();

    game = new GameObject();
    start();
}


Future<Null> start() async {
    await game.preloadManifest();
    Element container = new DivElement();
    container.style.display = "inline-block";
    querySelector('#output').append(container);
    if(game.player.petInventory.hasRoom) {
        game.drawAdoptables(container);
    }else {
        container.appendHtml("You have no more room for wigglers! Let the ones you have already grow up first!");
    }
}