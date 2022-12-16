import 'dart:io';

import 'package:day_15b/rhombus.dart';
import 'package:day_15b/utils.dart';

const size = 4000000;

void main(List<String> arguments) async {
  var rhombuses = <Rhombus>[];

  await for (final line in File('input.txt').readAsSections('\n')) {
    if (line.isEmpty) continue;
    final sensorL = line
        .split('Sensor at ')[1]
        .split(':')[0]
        .split(', ')
        .map((s) => int.parse(s.substring(2)))
        .toList();
    final sensor = Point(sensorL[0], sensorL[1]);

    final beaconL = line
        .split('closest beacon is at ')[1]
        .split(', ')
        .map((s) => int.parse(s.substring(2)))
        .toList();
    final beacon = Point(beaconL[0], beaconL[1]);

    rhombuses.add(Rhombus(
      sensor,
      (sensor.x - beacon.x).abs() + (sensor.y - beacon.y).abs(),
    ));
  }

  Point? pos;

  outer:
  for (final rhombus0 in rhombuses) {
    inner:
    for (final point in rhombus0.getPerimeter()) {
      if (!(point.x >= 0 && point.x < size && point.y >= 0 && point.y < size)) {
        continue;
      }

      for (final rhombus1 in rhombuses) {
        if (rhombus0 == rhombus1) continue;

        if (rhombus1.contains(point)) continue inner;
      }

      pos = point;
      break outer;
    }
  }

  print(pos!.x * 4000000 + pos.y);
}
