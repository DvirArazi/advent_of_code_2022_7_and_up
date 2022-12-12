import 'dart:io';

int? min(List<int?> nums) {
  int? rtn = nums[0];

  for (int i = 1; i < nums.length; i++) {
    final crnt = nums[i];
    if (crnt == null) continue;

    if (rtn == null || rtn > crnt) rtn = crnt;
  }

  return rtn;
}

void main(List<String> arguments) {
  final data = File('input.txt').readAsLinesSync();

  var layout = List.generate(
    data[0].length,
    (x) => List.generate(data.length, (y) => 1 << 31),
  );

  getHeight(int x, int y) {
    final char = data[y][x];
    return ({
              'S': 'a'.codeUnitAt(0),
              'E': 'z'.codeUnitAt(0),
            }[char] ??
            char.codeUnitAt(0)) -
        'a'.codeUnitAt(0);
  }

  int? visit(int x, int y, int distPrev, int heightPrev) {
    if (x < 0 || x >= layout.length || y < 0 || y >= layout[0].length) {
      return null;
    }

    int height = getHeight(x, y);

    final dist = distPrev + 1;

    if (heightPrev + 1 < height || layout[x][y] <= dist) {
      return null;
    }

    layout[x][y] = dist;

    if (data[y][x] == 'E') return dist;

    return min([
      visit(x, y - 1, dist, height),
      visit(x - 1, y, dist, height),
      visit(x + 1, y, dist, height),
      visit(x, y + 1, dist, height),
    ]);
  }

  var startX = 0;
  var startY = 0;

  findStart:
  for (int y = 0; y < data.length; y++) {
    for (int x = 0; x < data[0].length; x++) {
      if (data[y][x] == 'S') {
        startX = x;
        startY = y;
        break findStart;
      }
    }
  }

  print(visit(startX, startY, -1, 0));
}
