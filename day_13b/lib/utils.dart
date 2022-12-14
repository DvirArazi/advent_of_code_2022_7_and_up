// int ascii(String s) {
//   return s.codeUnitAt(0);
// }

// void ifVar<T>(T? Function() condition, Function(T) action) {
//   var val = condition();
//   if (val != null) {
//     action(val);
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';

extension StringExt on String {
  List<String> splitAt(List<int> indexes) {
    if (isEmpty) return [];
    if (indexes.isEmpty) return [this];

    List<String> rtn = List.generate(indexes.length + 1, (_) => "");

    rtn[0] = substring(0, indexes[0]);

    for (int i = 1; i < indexes.length; i++) {
      rtn[i] = substring(indexes[i - 1] + 1, indexes[i]);
    }

    rtn.last = substring(indexes.last + 1);

    return rtn;
  }
}

extension FileExt on File {
  Stream<String> readSections(String separator) async* {
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
