import 'package:DollLibCorrect/DollRenderer.dart';

class Stat {
    static int HIGH = 20;
    static int LOW = 0;
    static int MEDIUM = 10;
    static int VERYFUCKINGHIGH = 50;  //TODO figure out what's a rare but obtainable value once there's gameplay

    int value;
    String positiveName;
    String negativeName;

    //all flavor arrays will have default so doesn't sum to zero
    static StatFlavor defaultFlavor;



    //flavor will keep high, low, mediumm, very high, and caste shit
    StatFlavor positiveFlavor;
    StatFlavor negativeFlavor;

    static void makeDefaultFlavor() {
        defaultFlavor = new StatFlavor()
            ..jade = <String>[]
            ..fuchsia = <String>[]
            ..purple = <String>[]
            ..mutant = <String>[]
            ..veryHigh = <String>[]
            ..high = <String>[]
            ..medium = <String>[]
            ..low = <String>[];
    }

    Stat(this.value, this.positiveName, this.negativeName) {
        if(value == null) {
            Random rand = new Random();
            value = rand.nextIntRange(-1* HIGH, HIGH); //won't go above medium normally except rarely
        }

        if(Stat.defaultFlavor == null) {
            makeDefaultFlavor();
        }
    }

    int get normalizedValue => value.abs();

    String get stringValue {
        if(normalizedValue > VERYFUCKINGHIGH) return "Insanely High";
        if(normalizedValue > HIGH) return "High";
        if(normalizedValue > MEDIUM) return "Medium";
        if(normalizedValue >= LOW) return "Low";
        return "GLITCHED??? $normalizedValue";
    }

    @override
    String toString() {
        if(value >= 0) {
            return "$positiveName: $stringValue";
        }else {
            return "$negativeName: $stringValue";
        }
    }

}

/*
    Jumbled thoughts:

    Make some static premade vars of this for each stat type to have, one for pos, one for neg.

    when it's time to get middle, have a method that takes all stats and figures out
    which arrays to pick from.

 */
class StatFlavor {
    //any of these can be empty. it's okay. don't worry about it.
    List<String> high = new List<String>();
    List<String> medium = new List<String>();
    List<String> low = new List<String>();
    List<String> veryHigh = new List<String>();
    List<String> jade = new List<String>();
    List<String> fuchsia = new List<String>();
    List<String> purple = new List<String>();
    List<String> mutant = new List<String>();


}