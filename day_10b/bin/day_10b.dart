import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  String output = "";
  int cycle = 0;
  int x = 1;

  incCycle() {
    output += (x - cycle % 40).abs() <= 1 ? '#' : ' ';
    // print('$cycle $x');
    cycle += 1;
    if (cycle % 40 == 0) output += '\n';
  }

  for (var line in File('input.txt').readAsLinesSync()) {
    var inst = line.split(' ');
    switch (inst[0]) {
      case 'noop':
        incCycle();
        break;
      case 'addx':
        for (int i = 0; i < 2; i++) {
          incCycle();
        }
        x += int.parse(inst[1]);
        break;
    }

    // if (cycle >= 220) {
    //   break;
    // }
  }

  print(output);
}
