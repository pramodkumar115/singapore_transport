import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<List<int>> getFavoritesFromFile() async {
  bool fileExists = await checkIfFileExists("favorites.json");
  if (fileExists) {
    String filesDataString = await readFile("favorites.json");
    List<dynamic> filesData = json.decode(filesDataString);
    return filesData.map((f) => int.parse(f.toString())).toList();
  }
  return List.empty(growable: true);
}

Future<void> saveFavoritesFile(List<int> ids) async {
  writeData("favorites.json", json.encode(ids));
}


Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> _localFile(String filename) async {
  final path = await _localPath;
  return File('$path/$filename');
}

Future<bool> checkIfFileExists(String fileName) async {
  final file = await _localFile(fileName);
  return file.exists();
}

Future<File> writeData(String filename, String data) async {
  final file = await _localFile(filename);
  return file.writeAsString(data);
}

Future<String> readFile(String fileName) async {
  try {
    final file = await _localFile(fileName);
    // Read the file content as a string
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return "";
  }
}

