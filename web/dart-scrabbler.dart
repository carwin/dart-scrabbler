import 'dart:html';
import 'dart:math';

String scrabbleLetters = "aaaaaaabbccddddeeeffffggghhhiiijjjkkklllmmmnnnoooppqqqrrrsssttttttuuuvvvwwwwxxxxyyyyzzzz*";

List<ButtonElement> buttons = new List();
Element letterpile;
Element result;
ButtonElement clearButton;
Element worth;
int wordvalue = 0;

// 'index':text
Map scrabbleValues = { 'a':1, 'e':1, 'i':1, 'l':1, 'n':1,
                       'o':1, 'r':1, 's':1, 't':1, 'u':1,
                       'd':2, 'g':2, 'b':3, 'c':3, 'm':3,
                       'p':3, 'f':4, 'h':4, 'v':4, 'w':4,
                       'y':4, 'k':5, 'j':8, 'x':8, 'q':10,
                       'z':10, '*':0 };

void main() {
  letterpile = query('#letterpile');
  result = query('#result');
  worth = query('#value');
  clearButton = query('#clearButton');
  clearButton.onClick.listen(newletters);

  generateNewLetters();
}

void moveLetter(Event e) {
  Element letter = e.target;
  if (letter.parent == letterpile) {
    result.children.add(letter);
    wordvalue += scrabbleValues[letter.text];
    worth.text = "$wordvalue";
  } else {
    letterpile.children.add(letter);
    wordvalue -= scrabbleValues[letter.text];
    worth.text = "$wordvalue";
  }
}

void newletters(Event e) {
  letterpile.children.clear();
  result.children.clear();

  generateNewLetters();
}

generateNewLetters() {
  Random indexGenerator = new Random();
  wordvalue = 0;
  worth.text = '';
  buttons.clear();
  for (var i = 0; i < 7; i++) {
    // letterIndex is set to the next random a-z(*) letter.
    int letterIndex = indexGenerator.nextInt(scrabbleLetters.length);
    buttons.add(new ButtonElement());
    buttons[i].classes.add('letter');
    buttons[i].onClick.listen(moveLetter);
    // Make this button's text the value of the random a-z char matching pair
    // in the scrabbleLetters map.
    buttons[i].text = scrabbleLetters[letterIndex];
    letterpile.children.add(buttons[i]);
  }
}