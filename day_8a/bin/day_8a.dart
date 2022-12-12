import 'dart:io';

void main(List<String> arguments) {
  var data = File('input.txt').readAsStringSync();

  final width = data.indexOf('\n');

  data = data.replaceAll('\n', '');

  final height = data.length ~/ width;

  var seenLayout = List.generate(width, (_) => List.filled(height, false));

  hAt(int x, int y) {
    return int.parse(data[x + width * y]);
  }

  markSeen(bool a, bool b) {
    final s = {true: width, false: height};
    for (int i = 0; i < s[a]!; i++) {
      var tallest = -1;
      for (int j = 0; j < s[!a]!; j++) {
        final v = {true: i, false: b ? j : s[!a]! - 1 - j};

        final x = v[a]!;
        final y = v[!a]!;

        final h = hAt(x, y);
        if (tallest < h) {
          tallest = h;
          seenLayout[x][y] = true;
        } else if (tallest == 9) {
          break;
        }
      }
    }
  }

  markSeen(true, true);
  markSeen(true, false);
  markSeen(false, true);
  markSeen(false, false);

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      stdout.write(seenLayout[x][y] ? '^' : ' ');
    }
    stdout.write('\n');
  }

  var count = 0;
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      if (seenLayout[x][y]) count += 1;
    }
  }

  print(count);
}
