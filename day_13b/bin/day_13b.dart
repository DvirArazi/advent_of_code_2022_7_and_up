import 'dart:io';
import 'dart:math';

import 'package:day_13b/utils.dart';

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
  var packets = <Packet>[];

  await for (final line in File('input.txt').readSections('\n')) {
    if (line.isNotEmpty) packets.add(Packet(line));
  }

  final divider0 = Packet("[[2]]");
  final divider1 = Packet("[[6]]");

  packets.add(divider0);
  packets.add(divider1);

  packets.sort((a, b) => comparison(a, b) != Order.wrong ? -1 : 1);

  print(packets.indexOf(divider0));
  print(packets.indexOf(divider1));

  print((packets.indexOf(divider0) + 1) * (packets.indexOf(divider1) + 1));
}
