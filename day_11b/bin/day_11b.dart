import 'dart:async';
import 'dart:io';
// import 'dart:convert';

class Monkey {
  Monkey(String data) {
    final lines = data.split('\n');

    items = lines[1]
        .split('Starting items: ')[1]
        .split(',')
        .map((s) => int.parse(s))
        .toList();

    final opStuff = lines[2].split('Operation: new = old ')[1].split(' ');
    if (opStuff[1] == 'old') {
      operation = <String, int Function(int)>{
        // '+': (int num0) => num0 + num0,
        // '-': (int num0) => 0,
        '*': (int num0) => num0 * num0,
        // '/': (int num0) => 1,
      }[opStuff[0]]!;
    } else {
      final num1 = int.parse(opStuff[1]);
      operation = <String, int Function(int)>{
        '+': (int num0) => num0 + num1,
        '-': (int num0) => num0 - num1,
        '*': (int num0) => num0 * num1,
        // '/': (int num0) => num0 ~/ num1,
      }[opStuff[0]]!;
    }

    testNum = int.parse(lines[3].split('Test: divisible by ')[1]);

    monkeyT = int.parse(lines[4].split('If true: throw to monkey ')[1]);

    monkeyF = int.parse(lines[5].split('If false: throw to monkey ')[1]);
  }

  late List<int> items;
  late int Function(int) operation;
  late int testNum;
  late int monkeyT;
  late int monkeyF;
  int inspactionsCount = 0;
}

Future<void> main() async {
  // Stream<String> monkeysData = File('input.txt')
  //     .openRead()
  //     .transform(utf8.decoder)
  //     .transform(StreamTransformer.fromHandlers(handleData: (data, sink) {
  //   var parts = data.split('\n\n');
  //   for (var part in parts) {
  //     sink.add(part);
  //   }
  // }));
  final monkeysData = File('input.txt').readAsStringSync().split('\n\n');

  var monkeys = monkeysData.map((data) => Monkey(data)).toList();

  var lcm = monkeys[0].testNum;
  for (int i = 1; i < monkeys.length; i++) {
    for (int j = 1;; j++) {
      final newLcm = lcm * j;
      if (newLcm % monkeys[i].testNum == 0) {
        lcm = newLcm;
        break;
      }
    }
  }

  for (var i = 0; i < 10000; i++) {
    for (var monkey in monkeys) {
      for (var item in monkey.items) {
        item = monkey.operation(item) % lcm;
        monkeys[item % monkey.testNum == 0 ? monkey.monkeyT : monkey.monkeyF]
            .items
            .add(item);
        monkey.inspactionsCount += 1;
      }
      monkey.items = [];
    }
  }

  minI(List<int> nums) {
    var minI = 0;
    var min = nums[0];

    for (int i = 1; i < nums.length; i++) {
      if (min > nums[i]) {
        min = nums[i];
        minI = i;
      }
    }

    return minI;
  }

  var largests = List.generate(2, (_) => 0);
  for (var monkey in monkeys) {
    final i = minI(largests);
    if (largests[i] < monkey.inspactionsCount) {
      largests[i] = monkey.inspactionsCount;
    }
  }

  var result = 1;
  for (var largest in largests) {
    result *= largest;
  }

  print(result);
}
