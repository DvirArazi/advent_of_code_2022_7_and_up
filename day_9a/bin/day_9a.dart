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

void main(List<String> arguments) async {
  var poss = <Point>[];
  poss.add(Point(0, 0));

  var hPos = Point(0, 0);
  var tPos = Point(0, 0);

  for (var line in File('input.txt').readAsLinesSync()) {
    final dir = dirMap[line[0]]!;
    for (int i = 0; i < int.parse(line.split(' ')[1]); i++) {
      hPos += dir;
      final dist = distance(hPos, tPos);
      if (dist > 1) {
        final diff = tPos - hPos;
        final normDiff =
            Point((diff.x / dist).round(), (diff.y / dist).round());
        tPos = hPos + normDiff;
        if (!poss.contains(tPos)) {
          poss.add(tPos);
        }
      }
    }
  }

  print(poss.length);
}
