import 'dart:io';

void main(List<String> arguments) {
  var data = File('input.txt').readAsStringSync();

  final width = data.indexOf('\n');

  data = data.replaceAll('\n', '');

  final height = data.length ~/ width;

  hAt(int x, int y) {
    return int.parse(data[x + width * y]);
  }

  getScore(int x0, int y0) {
    scoreDir(bool h, bool p) {
      //horizontal (vs vertical), positive (vs negative)
      var score = 0;

      final inc = p ? 1 : -1;
      final c0 = (h ? x0 : y0) + inc;
      final max = h ? width : height;
      final cond = p ? (j) => j < max : (j) => j >= 0;

      for (int i = c0; cond(i); i += inc) {
        score += 1;
        if (hAt(x0, y0) <= (h ? hAt(i, y0) : hAt(x0, i))) {
          break;
        } else {
          continue;
        }
      }

      return score;
    }

    return scoreDir(true, true) *
        scoreDir(true, false) *
        scoreDir(false, true) *
        scoreDir(false, false);
  }

  var top = 0;

  for (int y = 0; y < width; y++) {
    for (int x = 0; x < height; x++) {
      final crnt = getScore(x, y);
      if (top < crnt) top = crnt;
    }
  }

  print(top);
}
