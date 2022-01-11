

import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FileHandeling extends StatefulWidget {
  const FileHandeling({Key? key}) : super(key: key);
  @override
  _FileHandelingState createState() => _FileHandelingState();
}

class _FileHandelingState extends State<FileHandeling> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('File Saver'),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                      labelText: "Name",
                      hintText: "Something",
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (!kIsWeb) {
                    if (Platform.isIOS || Platform.isAndroid) {
                      bool status = await Permission.storage.isGranted;

                      if (!status) await Permission.storage.request();
                    }
                  }
                  Excel excel = Excel.createExcel();
                  for (int i = 0; i < 10; i++) {
                    excel.insertRowIterables("Sheet1", ['a', i], i);
                  }
                  List<int>? sheets = await excel.encode();
                  Uint8List data = Uint8List.fromList(sheets!);
                  MimeType type = MimeType.MICROSOFTEXCEL;
                  String path = await FileSaver.instance.saveFile(
                      textEditingController.text == ""
                          ? "File"
                          : textEditingController.text,
                      data,
                      "xlsx",
                      mimeType: type);
                  print(path);
                },
                child: const Text("Save File")),
            if (!kIsWeb)
              if (Platform.isAndroid || Platform.isIOS)
                ElevatedButton(
                  onPressed: () async {
                    Excel excel = Excel.createExcel();
                    for (int i = 0; i < 10; i++) {
                      excel.insertRowIterables("Sheet1", ['a', i], i);
                    }
                    List<int>? sheets = await excel.encode();
                    Uint8List data = Uint8List.fromList(sheets!);
                    MimeType type = MimeType.MICROSOFTEXCEL;
                    String path = await FileSaver.instance.saveAs(
                        textEditingController.text == ""
                            ? "File"
                            : textEditingController.text,
                        data,
                        "xlsx",
                        type);
                    print(path);
                  },
                  child: const Text("Generate Excel and Open Save As Dialog"),
                ),


            ElevatedButton(
              onPressed: () async {
               // moveFile();
              //  /storage/emulated/0/Android/data/com.example.poc_delink/files

                try{

                    // var file = File('/storage/emulated/0/Android/data/com.example.poc_delink/files/shiwam.xlsx');
                    //  var path = file.path;
                    //  // var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
                    //  // var newPath = path.substring(0, lastSeparator + 1) + "shiwam.xlsx";
                    //  // file.renameSync(newPath);
                    // file.copy("/storage/emulated/0/Android/data/com.example.poc_delink/shiwam.xlsx");
                 moveFile(File("/storage/emulated/0/Android/data/com.example.poc_delink/files/fffff.xlsx"),"/storage/emulated/0/Android/data/com.example.poc_delink/fffff.xlsx");

                }
                catch(error){
                  print(error);
                }

              },
              child: const Text("move path"),
            )
          ],
        ),
      ),
    );
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      // prefer using rename as it is probably faster

      return await sourceFile.copy(newPath);
    } on FileSystemException catch (e) {
      // if rename fails, copy the source file and then delete it
      final newFile = await sourceFile.copy(newPath);
      await sourceFile.delete();
      return newFile;
    }
  }
}