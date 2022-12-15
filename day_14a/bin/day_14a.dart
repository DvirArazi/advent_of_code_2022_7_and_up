import 'dart:io';

import 'package:day_14a/utils.dart';

List<Point> lineToPoints(String line) {
  return line.split(' -> ').map((s) {
    final pointL = s.split(',').map((c) => int.parse(c)).toList();
    return Point(pointL[0], pointL[1]);
  }).toList();
}

enum Items { air, solid }

void main(List<String> arguments) async {
  final file = File('input.txt');

  var edge0 = Point(1 << 31, 0);
  var edge1 = Point(0, 0);

  await for (final line in file.readAsSections('\n')) {
    if (line.isEmpty) continue;
    for (final crnt in lineToPoints(line)) {
      if (edge0.x > crnt.x) {
        edge0.x = crnt.x;
      } else if (edge1.x < crnt.x) {
        edge1.x = crnt.x;
      }
      if (edge0.y > crnt.y) {
        edge0.y = crnt.y;
      } else if (edge1.y < crnt.y) {
        edge1.y = crnt.y;
      }
    }
  }

  final size = edge1 - edge0 + Point(1, 1);
  var layout =
      List.generate(size.x, (_) => List.generate(size.y, (_) => Items.air));
  setAt(Point p, Items value) {
    layout[p.x - edge0.x][p.y - edge0.y] = value;
  }

  Items? getAt(Point p) {
    final x = p.x - edge0.x;
    final y = p.y - edge0.y;

    if (x >= 0 && x < layout.length && y >= 0 && y < layout[0].length) {
      return layout[x][y];
    }

    return null;
  }

  await for (final line in file.readAsSections('\n')) {
    if (line.isEmpty) continue;
    final points = lineToPoints(line);
    for (int i = 1; i < points.length; i++) {
      final p0 = points[i - 1];
      final p1 = points[i];

      //I don't *love* that solution, but it works
      Point Function(int) getPoint;
      List<int> range;
      if (p0.x == p1.x) {
        getPoint = (c) => Point(p0.x, c);
        range = p0.y < p1.y ? [p0.y, p1.y] : [p1.y, p0.y];
      } else {
        getPoint = (c) => Point(c, p0.y);
        range = p0.x < p1.x ? [p0.x, p1.x] : [p1.x, p0.x];
      }

      for (int c = range[0]; c <= range[1]; c++) {
        setAt(getPoint(c), Items.solid);
      }
    }
  }

  var total = 0;

  outer:
  while (true) {
    var pos = Point(500, 0);
    inner:
    while (true) {
      switch (getAt(pos + Point(0, 1))) {
        case Items.air:
          pos.y += 1;
          break;
        case Items.solid:
          if (getAt(pos + Point(-1, 1)) != Items.solid) {
            pos += Point(-1, 1);
          } else if (getAt(pos + Point(1, 1)) != Items.solid) {
            pos += Point(1, 1);
          } else {
            setAt(pos, Items.solid);
            break inner;
          }
          break;
        case null:
          break outer;
      }
    }

    total += 1;
  }

  for (int y = 0; y < layout[0].length; y++) {
    for (int x = 0; x < layout.length; x++) {
      stdout.write(layout[x][y] == Items.solid ? '#' : '.');
    }
    stdout.write('\n');
  }
  stdout.write('\n');

  print(total);
}
