import 'dart:convert';
import 'dart:io';

import 'dart:math';

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
}

Future writeFiles() async {
  try {
    String dir = '/storage/emulated/0/folder_name';

    await new Directory(dir).create(recursive: true).then((value) {
      print('-- folder has been created in internal storage.');
    });

    // get dummy json
    var data = '[{}]'; // await Api.get('https://jsonplaceholder.typicode.com/todos');
    String jString = data.replaceAll(new RegExp(r"\s+"), "");

    // write json to file
    File file = File(dir + '/file_name.json');
    file.writeAsString(jString).then((value) {
      int fileSize = value.lengthSync();
      print('-- file_name.json has been written to internal storage (${formatBytes(fileSize, 1)}).');
    });
  } catch (e, s) {
    print('$e, $s');
  }
}

Future readFiles() async {
  try {
    String dir = '/storage/emulated/0/folder_name';

    // var files = !await Directory(dir).exists() ? [] : Directory(dir).listSync();

    // get all files
    // files.forEach((f) {
    //   File file = f;
    //   List<String> exts = ['.json'];
    //   String ext = extension(file.path);

    //   var fileSize = file.lengthSync();

    //   if (exts.contains(ext)) {
    //     p('${file.path} - Size: ${formatBytes(fileSize, 1)}');
    //   }
    // });

    // get specific file
    File file = File(dir + '/' + 'todos.json');
    if (await file.exists()) {
      String jString = await file.readAsString();
      List<Map<String, dynamic>> map = json.decode(jString).cast<Map<String, dynamic>>();
      print(map);
    } else {
      print('-- file does not exist.');
    }
  } catch (e, s) {
    print('$e, $s');
  }
}
