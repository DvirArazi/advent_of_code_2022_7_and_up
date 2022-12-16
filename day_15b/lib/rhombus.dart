import 'package:day_15b/utils.dart';

class Rhombus {
  Rhombus(this.center, this.path);

  Iterable<Point> getPerimeter() sync* {
    for (int i = 0; i <= path; i++) {
      yield Point(center.x - i, center.y - path - 1 + i);
      yield Point(center.x - path - 1 + i, center.y + i);
      yield Point(center.x + i, center.y + path + 1 - i);
      yield Point(center.x + path + 1 - i, center.y - i);
    }
  }

  bool contains(Point p) {
    return path >= (center.x - p.x).abs() + (center.y - p.y).abs();
  }

  Point center;
  int path;
}