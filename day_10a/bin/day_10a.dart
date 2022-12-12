import 'dart:io';

void main(List<String> arguments) {
  int strengthSum = 0;
  int cycle = 0;
  int x = 1;

  incCycle() {
    cycle += 1;
    if ((cycle - 20) % 40 == 0) {
      strengthSum += cycle * x;
      // print('$cycle: $strengthSum');
    }
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

    if (cycle >= 220) {
      break;
    }
  }

  print(strengthSum);
}
