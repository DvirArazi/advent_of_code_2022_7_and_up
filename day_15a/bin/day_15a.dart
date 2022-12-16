import 'dart:io';

import 'package:day_15a/utils.dart';

const height = 2000000;

class Range {
  Range(this.a, this.b);

  int a;
  int b;
}

void main(List<String> arguments) async {
  var ranges = <Range>[];
  var rowRange = Range(1 << 31, 0);

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

    final pathLength =
        (sensor.x - beacon.x).abs() + (sensor.y - beacon.y).abs();
    final radius = pathLength - (sensor.y - height).abs();
    if (radius < 0) continue;

    final range = Range(sensor.x - radius, sensor.x + radius);

    ranges.add(range);

    if (rowRange.a > range.a) rowRange.a = range.a;
    if (rowRange.b < range.b) rowRange.b = range.b;
  }

  var row = List.generate(rowRange.b - rowRange.a, (_) => false);

  for (final range in ranges) {
    for (int i = range.a - rowRange.a; i < range.b - rowRange.a; i++) {
      row[i] = true;
    }
  }

  print(row.where((e) => true).length);
}
