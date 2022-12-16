import 'dart:io';

import 'package:day_15b/utils.dart';

const size = 4000000;

class Rhombus {
  Rhombus(this.center, this.path);

  Point center;
  int path;
}

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
    // final pathLength =
    //     (sensor.x - beacon.x).abs() + (sensor.y - beacon.y).abs();
    // final radius = pathLength - (sensor.y - height).abs();
    // if (radius < 0) continue;
    // final range = Range(sensor.x - radius, sensor.x + radius);

    // rhombuses.add(range);

    // if (rowRange.a > range.a) rowRange.a = range.a;
    // if (rowRange.b < range.b) rowRange.b = range.b;
  }

  Point? pos;

  outer:
  for (int x = 0; x < size; x++) {
    inner:
    for (int y = 0; y < size; y++) {
      for (final rhombus in rhombuses) {
        final crntPath =
            (rhombus.center.x - x).abs() + (rhombus.center.y - y).abs();
        if (rhombus.path < crntPath) continue inner;
      }

      pos = Point(x, y);
      break outer;
    }
  }

  print(pos);

  // var row = List.generate(rowRange.b - rowRange.a, (_) => false);

  // for (final range in rhombuses) {
  //   for (int i = range.a - rowRange.a; i < range.b - rowRange.a; i++) {
  //     row[i] = true;
  //   }
  // }

  // print(row.where((e) => true).length);
}
