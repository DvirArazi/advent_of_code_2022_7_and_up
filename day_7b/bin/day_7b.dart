import 'dart:io';

class Dir {
  Dir(this.parent);

  int memory = 0;
  final Dir? parent;
  late Map<String, Dir> dirs = {};
}

void main(List<String> arguments) {
  Dir rootDir = Dir(null);
  Dir crntDir = rootDir;

  final file = File('input.txt');
  for (var line in file.readAsLinesSync()) {
    inner:
    {
      if (line.startsWith("\$ cd ")) {
        final dir = line.split("\$ cd ")[1];
        switch (dir) {
          case "/":
            crntDir = rootDir;
            break;

          case "..":
            crntDir.parent!.memory += crntDir.memory;
            crntDir = crntDir.parent!;
            break;

          default:
            crntDir = crntDir.dirs[dir]!;
            break;
        }

        break inner;
      }

      if (line.startsWith("dir ")) {
        final dir = line.split("dir ")[1];
        crntDir.dirs[dir] = Dir(crntDir);

        break inner;
      }

      final memory = int.tryParse(line.split(" ")[0]);
      if (memory != null) {
        crntDir.memory += memory;

        break inner;
      }
    }
  }

  addDown(Dir crntDir) {
    final parent = crntDir.parent;
    if (parent == null) return;
    parent.memory += crntDir.memory;
    addDown(parent);
  }
  addDown(crntDir);

  final sp = rootDir.memory - 40000000;
  var sdm = 1 << 31;

  checkUp(Dir crntDir) {
    for (var dir in crntDir.dirs.values) {
      checkUp(dir);
      if (dir.memory - sp >= 0 && dir.memory < sdm) {
        sdm = dir.memory;
      }
    }
  }
  checkUp(rootDir);

  print(sdm);
}
