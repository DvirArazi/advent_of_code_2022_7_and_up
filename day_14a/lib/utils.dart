import 'dart:async';
import 'dart:convert';
import 'dart:io';

class Point {
  Point(this.x, this.y);

  int x;
  int y;

  Point operator +(Point other) {
    return Point(x + other.x, y + other.y);
  }

  Point operator -(Point other) {
    return Point(x - other.x, y - other.y);
  }
}

// class PointRange {
//   PointRange(Point p0, Point p1) {
//     if (p0.x == p1.x) {
//       _isX = false;
//       if (p0.y < p1.y) {
//         _start = p0;
//         _c = 
//       }
//     } else {
//       _isX = false;
//       if (p0.x < p1.x) {
//         _start = p0;
//       } else {

//       }
//     }
//   }

//   late Point _start;
//   late int _c;
//   late bool _isX;
// }

extension FileExt on File {
  Stream<String> readAsSections(String separator) async* {
    yield* openRead()
        .transform(utf8.decoder)
        .transform(StreamTransformer.fromHandlers(handleData: (data, sink) {
      var parts = data.split(separator);
      for (var part in parts) {
        sink.add(part);
      }
    }));
  }
}
