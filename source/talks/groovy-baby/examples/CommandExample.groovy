class Say {
    String phrase;
 
    static def say(phrase) {
        new Say(phrase: phrase)
    }
       
    def to(person) {
        "$phrase, $person."
    }
}

import static Say.say

say "Thank you and goodnight" to "OSDC"