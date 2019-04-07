import 'dart:convert';
import 'dart:html';

import '../GameShit/GameObject.dart';

abstract class LoginHandler {
    static String LOGINLOCATION = "WIGGLERSIMLOGIN";


    static bool hasLogin() {
        return window.localStorage.containsKey(LOGINLOCATION);
    }

    static void storeLogin(String login, String password, String name, String desc, String doll ) {
        //    LoginInfo(String this.login, String this.password, String this.name, String this.desc, String this.doll);
        window.localStorage[LOGINLOCATION] = new LoginInfo(login, password, name, desc, doll).toJSON();
    }

    static void clearLogin() {
        window.localStorage.remove(LOGINLOCATION);
    }

    //either who you are currently logged in as and an option to log out
    //or a form for logging in.
    static DivElement loginStatus() {
        if(hasLogin()) {
            return displayLoginDetails();
        }else {
            return displayLogin();

        }
    }

    //the controler itself will handle checking if the info is valid
    static DivElement displayLoginDetails() {
        LoginInfo yourInfo = LoginHandler.fetchLogin();
        DivElement ret = new DivElement()..text = "Greetings, ${yourInfo.login}.";
        ret.style.textAlign = "left";
        ButtonElement button = new ButtonElement()..text = "Log Out";
        ret.append(button);
        return ret;
    }

    static DivElement displayLogin() {
        DivElement ret = new DivElement()..text = "Login to Sweepbook (or create a login).";
        DivElement first = new DivElement()..style.padding="10px";
        ret.append(first);
        DivElement second = new DivElement()..style.padding="10px";
        ret.append(second);
        DivElement third = new DivElement()..style.padding="10px";
        ret.append(third);

        LabelElement labelLogin = new LabelElement()..text = "Login:";
        InputElement login = new InputElement();
        first.append(labelLogin);
        first.append(login);
        LabelElement labelPW = new LabelElement()..text = "Password:";
        InputElement pw = new PasswordInputElement();
        first.append(labelPW);
        first.append(pw);

        LabelElement descLabel = new LabelElement()..text = "Description: (don't be a dick here, ppl can se it)";
        InputElement desc = new PasswordInputElement();
        first.append(descLabel);
        first.append(desc);

        GameObject game = GameObject.instance;



        ButtonElement button = new ButtonElement()..text = "Login to Sweepbook";
        ret.append(button);
        ret.append(new DivElement()..text = "(This is required to engage with the TIMEHOLE now, by Emperial decree.)");
        ret.append(new DivElement()..text = "(WARNING: This is very simple, don't put passwords you use other places here.)");

        button.onClick.listen((Event e)
        {
            storeLogin(login.value, pw.value, desc.value, game.player.name, game.player.doll.toDataBytesX());
            //when logged in should probably refresh the page.
            window.location.href = window.location.href;

        });

        return ret;

    }

    static LoginInfo fetchLogin() {
        return LoginInfo.fromJSON(window.localStorage[LOGINLOCATION]);
    }
}

class LoginInfo{
    String login;
    String password;
    String desc;
    String name;
    String doll;
    LoginInfo(String this.login, String this.password, String this.name, String this.desc, String this.doll);

    @override
    String toJSON() {
        return jsonEncode({"login":login, "password":password, "desc": desc, "doll":doll, name: "name"});
    }

    LoginInfo.fromJSON(String json){
        var tmp = jsonDecode(json);
        login = tmp["login"];
        password = tmp["password"];
        password = tmp["desc"];
        password = tmp["doll"];
        password = tmp["name"];
    }

    Future<String> confirmedInfo()async {
        //TODO send my info to the server to confirm it.
        //its a get on caretakers/caretakeridbylogin and i pass login and password. i'll get a true/false back
        //if i get a 200 back everything is good, just return 200
        //if i get anything else back return the error message
        LoginInfo yourInfo = LoginHandler.fetchLogin();
        try {
            return await HttpRequest.getString("http://localhost:3000/caretakers/confirmedLogin?${yourInfo.toJSON()}");

        }catch(error, trace) {
            window.alert("ERROR: cannot access TIMEHOLE system.");
        }
    }

}