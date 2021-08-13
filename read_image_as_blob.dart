import 'dart:io';

import 'dart:typed_data';
// import 'package:flutter/services.dart'; -> rootBundle.load('profile.png')
// export 'package:path_provider/path_provider.dart'; -> await getTemporaryDirectory()

// ByteData is Blob
// The best solution to save image to sqflite is to use ByteData or Blob,
// source: https://stackoverflow.com/questions/52170790/how-to-save-image-data-to-sqflite-database-in-flutter-for-persistence

Future readImg() async {
  try {
    String dir = '/storage/emulated/0/blanj';
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = dir + '/file_01.png';

    ByteData data = await rootBundle.load('image.png');
    final buffer = data.buffer;
    File file = await File(filePath).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));

    Uint8List bytes = await file.readAsBytes();
  } catch (e, s) {
    print('$e, $s');
  }
}


// to show Uint8List, Container(child: Image.memory(bytes))