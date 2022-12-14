import 'dart:io';
import 'dart:math';

import 'package:day_13a/utils.dart';

class Packet {
  List<Packet>? list;
  int? item;

  Packet(String data) {
    {
      var itemO = int.tryParse(data);
      if (itemO != null) {
        item = itemO;
        return;
      }
    }

    data = data.substring(1, data.length - 1);

    var splitIs = <int>[];
    {
      var depth = 0;
      for (int i = 0; i < data.length; i++) {
        switch (data[i]) {
          case '[':
            depth += 1;
            break;
          case ']':
            depth -= 1;
            break;
          case ',':
            if (depth == 0) {
              splitIs.add(i);
            }
            break;
        }
      }
    }

    list = [];
    for (var slice in data.splitAt(splitIs)) {
      list!.add(Packet(slice));
    }
  }

  Packet.list(this.list);
  Packet.item(this.item);

  void wrap() {
    if (item == null) return;

    list = [Packet.item(item)];
    item = null;
  }
}

enum Order {
  unknown,
  wrong,
  right,
}

Order comparison(Packet packet0, Packet packet1) {
  if (packet0.item != null && packet1.item != null) {
    if (packet0.item! == packet1.item!) return Order.unknown;
    return packet0.item! < packet1.item! ? Order.right : Order.wrong;
  }

  packet0.wrap();
  packet1.wrap();

  final len0 = packet0.list!.length;
  final len1 = packet1.list!.length;
  for (int i = 0; i < min(len0, len1); i++) {
    final order = comparison(packet0.list![i], packet1.list![i]);
    if (order != Order.unknown) return order;
  }

  return {
    len0 < len1: Order.right,
    len0 > len1: Order.wrong,
    len0 == len1: Order.unknown
  }[true]!;
}

void main(List<String> arguments) async {
  var total = 0;
  var index = 1;

  await for (final section in File('input.txt').readSections('\n\n')) {
    final lines = section.split('\n');
    var packet0 = Packet(lines[0]);
    var packet1 = Packet(lines[1]);

    if (comparison(packet0, packet1) != Order.wrong) {
      total += index;
    }

    index += 1;
  }

  print(total);
}
