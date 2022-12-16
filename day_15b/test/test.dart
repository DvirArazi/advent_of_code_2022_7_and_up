import 'package:day_15b/rhombus.dart';
import 'package:day_15b/utils.dart';
import 'package:test/test.dart';

void main() {
  test('getPerimeter', () {
    expect(Rhombus(Point(4, 5), 1).getPerimeter().toList(),
        [
          Point(4, 3), Point(2, 5), Point(4, 7), Point(6, 5),
          Point(3, 4), Point(3, 6), Point(5, 6), Point(5, 4),
        ]);
  });
}
