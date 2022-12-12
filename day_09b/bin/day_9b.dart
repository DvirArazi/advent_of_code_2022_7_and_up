import 'dart:io';
import 'dart:math';

final Map<String, Point<int>> dirMap = {
  'U': Point(0, 1),
  'L': Point(-1, 0),
  'R': Point(1, 0),
  'D': Point(0, -1)
};

double distance(Point a, Point b) {
  return sqrt(pow(b.x - a.x, 2.0) + pow(b.y - a.y, 2.0));
}

void main(List<String> arguments) {
  var poss = <Point>[];
  poss.add(Point(0, 0));

  var rPoss = List.generate(10, (_) => Point(0, 0));

  for (var line in File('input.txt').readAsLinesSync()) {
    final dir = dirMap[line[0]]!;
    for (int i = 0; i < int.parse(line.split(' ')[1]); i++) {
      rPoss[0] += dir;
      for (int j = 1; j < rPoss.length; j++) {
        final dist = distance(rPoss[j - 1], rPoss[j]);
        if (dist > 1) {
          final diff = rPoss[j] - rPoss[j - 1];
          final normDiff =
              Point((diff.x / dist).round(), (diff.y / dist).round());
          rPoss[j] = rPoss[j - 1] + normDiff;
        }
      }
      if (!poss.contains(rPoss.last)) {
        poss.add(rPoss.last);
      }
    }
  }

  // for (int y = 10 - 1; y >= -10; y--) {
  //   for (int x = -15; x < 15; x++) {
  //     stdout.write(poss.contains(Point(x, y)) ? '#' : '*');
  //   }
  //   stdout.write('\n');
  // }

  print(poss.length);
}
