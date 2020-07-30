import 'package:flutter/material.dart';
import 'package:glee/diary/diary.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController _titleController = new TextEditingController();
  File jsonFile;
  Directory dir;
  String fileName = "dreamDiary.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) this.setState(() => fileContent = jsonDecode(jsonFile.readAsStringSync()));
    });
  }

  void createFile(Map<String, dynamic> content, Directory dir, String fileName) {
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(jsonEncode(content));
  }

  void writeToFile(String key, dynamic value) {
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      Map<String, dynamic> jsonFileContent = jsonDecode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(jsonEncode(jsonFileContent));
    } else {
      createFile(content, dir, fileName);
    }
    this.setState(() => fileContent = jsonDecode(jsonFile.readAsStringSync()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add new entry"),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "What did you dream about?",
              ),
              controller: _titleController,
              keyboardType: TextInputType.multiline,
              minLines: 10,
              maxLines: 50,
            ),
            margin: EdgeInsets.all(20),
            elevation: 6,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          writeToFile(DateTime.now().toString(), _titleController.text);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Diary()));
      },
        child: Icon(Icons.save_alt),
      ),
    );
  }
}