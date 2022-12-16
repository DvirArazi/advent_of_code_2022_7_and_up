import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

  @override
  String toString() {
    return '($x, $y)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Point &&
        x == other.x &&
        y == other.y;
  }

  @override
  int get hashCode {
    return x.hashCode ^ y.hashCode;
  }
}
